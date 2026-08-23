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

### Desktop and headless machines

Common files are tracked at their normal paths. Desktop-only files use yadm's
`##desktop` alternate suffix and are materialized only for the `desktop`
class. The current desktop-only files are the tmux pair, Tilda configuration
and autostart, monitor movement, the `tm` and `wk` workstation helpers, and
voice dictation configuration and tooling. `eyes` and `gdo` remain common.

Set the local class before materializing alternates:

```sh
yadm config local.class desktop
yadm alt
```

For a headless host, select the `headless` class instead:

```sh
yadm config local.class headless
yadm alt
```

Use `yadm alt` to inspect alternate handling. When changing classes, review
previously materialized files and the resulting yadm update, since files from a
previous class may need to be removed separately.

If you just want to browse or borrow a single file, clone it as a normal repo:

git clone git@github.com:alopexplenus/dotfiles.git
```sh
```

```
