# AGENTS.md

Guidance for AI agents working in this repository.

## What this repo is

Personal dotfiles managed with [yadm](https://yadm.io). This is a public repo
intended mainly for personal use.

## How to work in this repo (rules)

These are directives, not background. Follow them.

- **Work in the workdir.** Every config or dotfile you touch lives **in this
  repo** (e.g. `.config/`, `.zshrc`, `.tmux.conf`, `profiles/`, `commands/`).
  Look here first. This is where you make changes.

- **Config questions are about THIS repo.** Any general configuration question
  in this project — "how is X configured", "what does this setting do", "change
  this behavior" — refers to the configuration **in this repo**, not the live
  configs in `$HOME`. Do **not** go read `~` to answer a config question unless
  the user explicitly asks you to.

- **The repo is canonical; syncing is manual.** The repo is the source of truth.
  Configs are synced to `$HOME` **manually by the user** (via yadm). Never edit
  files under `$HOME`, and never assume `$HOME` reflects the repo. If you notice
  drift between the two, **mention it — do not "fix" it.**

- **Missing config → propose adding it.** If a config the user references is
  **not present in the repo**, suggest adding it. To seed it from the live
  version, you **must ask permission before reading anything under `$HOME`**,
  then use that as a starting point for a new tracked file here. Strip secrets
  and private paths per "NEVER commit sensitive data" below.

Before working on any config:

1. Is it in the repo? → work on it here.
2. Not in the repo? → propose adding it; ask before reading `~` to seed it.
3. Answering a config question? → answer from repo files, not `~`.
4. Never edit `~` or assume `~` matches the repo. Flag drift, don't fix it.

## The agent's own settings live here too

This repo also manages the **opencode** configuration under
[`.config/opencode/`](.config/opencode/) — `opencode.json`, the per-mode
`profiles/`, `instructions/`, `commands/`, `plugins`, and related files. When
you edit opencode's behavior, agents, skills, commands, or permissions, you are
editing files in **this repo**.

Everything below applies to those files exactly as it does to any other dotfile:
they are **not** symlinked (see next section), editing this clone does not change
the live opencode config until it's committed, pushed, and pulled with yadm, and
**no secrets** (API keys, tokens) may be committed to them.

## Dotfiles are NOT symlinked

**yadm does not symlink.** It tracks files directly, in place, inside `$HOME`.
The real, live dotfiles live at their natural paths in the home directory
(e.g. `~/.zshrc`, `~/.tmux.conf`), and yadm's git repo lives in `~/.local/share/yadm/repo.git`.

Practical consequences:

- Do **not** create, expect, or "fix" symlinks between this repo and `$HOME`.
- This checkout is a **plain clone**, not the
  live yadm worktree. Editing files here does **not** change the live dotfiles
  in `$HOME` unless the change is committed, pushed, and pulled with yadm.
- do *not* change the *active* config on this machine.

## NEVER commit sensitive data

Do not, under any circumstances, commit secrets or private information. This
repo is **public**. That includes, but is not limited to:

- API keys, tokens, passwords, credentials, session cookies
- SSH/GPG private keys
- `.env` files and anything with secrets in it
- Personal/private paths, hostnames, IPs, or identifiers that shouldn't be public
- Machine- or work-specific secrets

If a config needs a secret, keep the secret out of the tracked file (env var,
local-only untracked file, or yadm's encryption). When in doubt, **leave it out
and ask.**

Anything under `mystuff/` and other paths in `.gitignore_global` is intentionally
kept out of version control — respect those ignores.
