---
date: 2024-06-17 00:06
---

# WordPress Reproducible Build

Had a task recently that essentially involved automating a Docker deployment of a WordPress blog. It was purely for testing purposes, so please note that most of its configuration is insecure as hell. Nonetheless, I spent 4 hours debugging an issue I thought was worth sharing and key to this task: I wanted the Docker containerization process to programmatically handle user creation and plugin installation.

The idea is that we might need to frequently discard the blog, and we don't want to go through all the trouble of installing WordPress, installing specific versions of the plugins we want, and creating users with different privilege levels each time. Ultimately, we don't really care for most of that, so it's okay to use insecure defaults.

So, we have a project tree that contains a folder `./plugins/vulnerable/` and some other dependency plugins that are required to use/activate in `./plugins/core`. I spent 3 hours debugging why `wp-cli` was not installing the plugins due to an unforeseen need to escape the `$` in the bash commands we were using just to get this going.

PS: I am aware that using volumes to store the database and WordPress data would be better than bind mounts. For this case, this is sufficient really, and we don't want to over-engineer things[^1]. For a serious project, I'd recommend using volumes. The attached link explains this better than I can.

```
services:
  db:
    image: mysql:8.0
    restart: always
    environment:
      ...
    volumes:
      - ./data/db:/var/lib/mysql

  wordpress:
    image: wordpress:6.5.2-php8.3-apache
    depends_on:
      - db
    restart: always
    ports:
      - 8080:80
    volumes:
      - ./data/wordpress:/var/www/html
      - ./plugins:/tmp/plugins

  wp-cli:
    env_file: .env
    image: wordpress:cli-php8.3
    user: "33:33"  # hack for https://stackoverflow.com/questions/57136171/execute-a-plugin-installed-wp-cli-command-with-docker-compose
    depends_on:
      - wordpress
    volumes_from:
      - wordpress:rw
    command: >
      /bin/sh -c '
      sleep 10;
      wp core install --path="/var/www/html" --url="http://localhost:8080" --title="DVWPS" --admin_user=admin --admin_password=secret --admin_email=x@x.com;
      wp user create tester y@y.com --user_pass=megasecret --role=subscriber;
      for plugin in /tmp/plugins/**/*.zip; do
        wp plugin install $${plugin} --activate;
      done;'
```

That `$${plugin}` is the difference between `wp-cli` being capable of installing the plugins or not. I couldn't see why the compose service was returning empty strings, even when I tried for plugin in `/tmp/plugins/**/*.zip; do echo $plugin; done;` and was too focused on directory permissions. In this case, it felt reasonable as the `wp-cli` needs to be capable of writing to directories that belong to another container in this setup. I tried a bunch of things until eventually, I tried installing one plugin I knew existed - it worked. "Damn, this has to be an issue with the bash commands then," and it was...

As for the `user: "33:33"` directive, I kept encountering permission issues because WordPress `Dockerfile` sets most directories for user `www-data` and the `wp-cli` runs with a different user. Furthermore, this is a shared bind volume, and it seems `volumes_from` isn't sufficient. This appears to be a known problem already, highlighted in that StackOverflow question. This fakes the running user UID and GID as `www-data`.

[^1]: https://docs.docker.com/storage/volumes/
