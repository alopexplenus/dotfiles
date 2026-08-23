# Shell completions, sourced from ~/.zshrc.
#
# Note: the `wk` completion below uses bash-style completion
# (compgen/COMPREPLY/complete). That works under zsh only if
# `bashcompinit` has been initialised (autoload -Uz bashcompinit && bashcompinit).

# --- `run` command (native zsh) ---
# arg 1  -> names of scripts in ./scripts/ (relative to the current directory)
# arg 2+ -> normal path/file completion, so it never blocks completing paths
#           passed as arguments to the chosen script.
_run_autocomplete() {
    if (( CURRENT == 2 )); then
        local -a scripts
        scripts=( ${(f)"$(ls ./scripts/ 2>/dev/null)"} )
        compadd -a scripts
    else
        _files
    fi
}

compdef _run_autocomplete run

# --- `wk` (wake) command (bash-style completion) ---
_wake_autocomplete()
{
    local cur
    COMPREPLY=( $( compgen -W "$(ls ~/projects/)" -- "$cur"  )  )
    return 0
}

complete -o nospace -F _wake_autocomplete wk
