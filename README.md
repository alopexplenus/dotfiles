# dotfiles

My personal dotfiles and configuration, managed with [yadm](https://yadm.io).

## ⚠️ Disclaimer

These are **personal** dotfiles. This repository is public for convenience and
reference only — it is **not** intended as a general-purpose, install-anywhere
dotfiles framework.

- Configs are tailored to my machines, tools, and habits. They may not suit you.
- Things may change, break, or disappear without notice.
- **No warranty.** Read anything before you run it on your system.
- Copy the bits you find useful rather than adopting the whole thing wholesale.

## What's in here

Shell (`.zshrc`, `.bashrc`, `.profile`), tmux (`.tmux.conf*`), Vim/IdeaVim
(`.vimrc`, `.ideavimrc`), git (`.gitconfig`, `.gitignore_global`), `.config/`,
plus a handful of helper scripts.

## Usage

This repo is managed with **yadm**, which tracks dotfiles directly in `$HOME`
(no symlinks — see [AGENTS.md](AGENTS.md)).

To use it on a fresh machine:

```sh
# install yadm first (e.g. via your package manager), then:
yadm clone git@github.com:alopexplenus/dotfiles.git
```

yadm will lay the files down in your home directory. Review before applying.

If you just want to browse or borrow a single file, clone it as a normal repo:

git clone git@github.com:alopexplenus/dotfiles.git
```sh
```

```
