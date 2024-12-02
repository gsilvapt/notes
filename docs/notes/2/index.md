---
date: 2024-05-02 16:58
---

# Updating your host's SSH keys

If you have servers which you connect to frequently via SSH and those servers happen to be under frequent deploys, your SSH keys might no longer work with an error similar to:

`<username>@<hostname>: Permission denied (publickey,password).`

This happens because the resulting server public key you get after the initial exchange is no longer valid as the server was destroyed and brought back up. A simple solution is to simply run  `ssh-keygen -R <hostname>` to remove the old key and then try to connect again.

