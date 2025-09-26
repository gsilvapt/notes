---
date: 2025-09-26 10:45
---

# Lazygit and GPG

Ever since I found out anyone can sign commits using anyone's email, I decided to use GPG for git development work, whether it's personal or professional, whether people appreciate it or not.

Some open-source projects these days require it, and I want to believe some companies have started to enforce this on their employees, with all the supply chain attacks and forms of compromise.

Thus, I have a whole section in my `gitconfig` file dedicated to GPG signing. And it let's me do cool things too.

Usually, there's a global key assigned in my `$HOME/.gitconfig`:

```
[user]
    email = <my_mail>
    name = <the name I want to see in my commits>
    signingkey = DEADB33FD34DB33f
```

In all `git` operations, this default configuration file is used. However, git allows local configurations, meaning users can set specific attributes for specific repositories. That said, I created a cute `zsh` alias called `set_personal` that I use to set a different signing key and email:

```
alias set_personal='git config --local user.signingkey PERSONALD34DB33F && git config --local user.email <another_email>'
```

Of course, more parameters could be configured this way but that's enough for me. This get's stored in `<repo>/.git/config` file and overrides the configuration from `$HOME/.gitconfig`.

Pretty neat.


But the problem came when I wanted to use [Lazygit](https://github.com/jesseduffield/lazygit). I love the terminal and I think Lazygit is one of the best interfaces for Git. It's way prettier, cleaner and more intuitive than [`tig`](https://github.com/jonas/tig). I would like to find something similar to `magit` for neovim, but so far I never did.

The problem with Lazygit is that it fails to manage GPG signing. I've come across so many problems[^1][^2], it's not even funny. The latest time this happened it froze the `gpg-agent` and I could not even proceed manually, which is what I normally do.

And as opposed to what some issues in the repository mention, I don't think it's only on `pinentry` programs - I have experienced some issues, albeit less, on Linux environments.

Solution? Well, I only use `lazygit` now to do advanced adds - like when adding only a portion of changes as I always fail to use `git add -p <file>`. After that, I quit and proceed manually.

After coming across this[^3] post, I also felt less and less the need to use `Lazygit`. Especially the `diff` changes are astonishingly better.

[^1]: https://github.com/jesseduffield/lazygit/issues/4668
[^2]: https://github.com/jesseduffield/lazygit/issues/3308
[^3]: https://blog.gitbutler.com/how-git-core-devs-configure-git

