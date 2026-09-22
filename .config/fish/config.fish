# Fish configuration translated from ~/.zshrc.

# Keep CachyOS-provided fish defaults when available.
if test -r /usr/share/cachyos-fish-config/cachyos-config.fish
    source /usr/share/cachyos-fish-config/cachyos-config.fish
end

# Replace the CachyOS fastfetch greeting with a compact timestamped line.
function fish_greeting
    echo (whoami)@(hostname) (date '+%Y-%m-%d %H:%M')
end

# General command shortcuts.
alias l 'ls -lAh'
alias ll 'ls -lh'
alias la 'ls -lah'
alias lsn 'ls -lth | head -n 20'
alias xo xdg-open
alias gd 'git diff'
alias ga 'git add'
alias gc 'git commit'
alias nv nvim
alias oc-recap '~/.config/opencode/recap/recap-collect'
alias vfn 'vim (fzf)'
alias vfb 'vim (rg . | fzf | cut -d ":" -f 1)'
alias pm './run pre-merge'
alias fix './run lint --fix'

# Show fish_git_prompt's uncommitted-change marker in red.
set -g __fish_git_prompt_color_dirtystate red

# Wake up a project with its existing helper script.
function wk
    set -lx jobs_count (jobs | wc -l)
    command wk $argv
end

function gs
    git stash push -m "zsh_stash_name_$argv[1]"
end

function gsa
    set -l stash (git stash list | string match -r "^[^:]+(?=:.*zsh_stash_name_$argv[1])" | head -n 1)
    test -n "$stash"; and git stash apply $stash
end

# OpenCode mode launcher. A repo can pin its mode in .ocmode.
function oc
    set -l modes corp hack
    set -l root (git rev-parse --show-toplevel 2>/dev/null)
    set -l pin
    if test -n "$root"; and test -r "$root/.ocmode"
        set pin (string collect < "$root/.ocmode" | string trim)
    end

    set -l mode
    if test -n "$pin"
        if test (count $argv) -gt 0; and contains -- $argv[1] $modes; and test "$argv[1]" != "$pin"
            echo "oc: repo is pinned to '$pin'; refusing to launch as '$argv[1]'." >&2
            return 1
        end
        set mode $pin
        if test (count $argv) -gt 0; and test "$argv[1]" = "$pin"
            set -e argv[1]
        end
    else if test (count $argv) -gt 0; and contains -- $argv[1] $modes
        set mode $argv[1]
        set -e argv[1]
    else if test (count $argv) -gt 0
        echo "oc: unknown mode '$argv[1]' (expected: corp or hack)." >&2
        return 1
    else
        read -P 'mode (corp/hack): ' mode
        contains -- $mode $modes; or return 1
    end

    set -l config_dir "$HOME/.config/opencode/profiles/$mode"
    if not test -r "$config_dir/opencode.json"
        echo "oc: profile not found: $config_dir/opencode.json" >&2
        return 1
    end

    echo "oc: launching in '$mode' mode." >&2
    env OPENCODE_CONFIG="$config_dir/opencode.json" OPENCODE_CONFIG_DIR="$config_dir" opencode $argv
end

# Do not allow accidental force pushes; use --force-with-lease instead.
function git
    if test "$argv[1]" = push; and test (count $argv) -gt 1
        if string match -q -- '-f*' "$argv[2]"; or string match -q -- --force "$argv[2]"
            echo 'Use --force-with-lease instead'
            return 1
        end
    end
    command git $argv
end

function ww
    cd ~/notes; and tmux rename-window notes; and vim (cat .latest_weekly_note)
end

# fzf integration and appearance.
set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'
set -gx FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window down:3:wrap"
if type -q fzf
    fzf --fish | source
end

# Load .envrc files when direnv is installed.
if type -q direnv
    direnv hook fish | source
end
