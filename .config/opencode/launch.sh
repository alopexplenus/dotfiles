# OpenCode mode launcher. Sourced from ~/.zshrc; defines the `oc` function.
# Modes: corp | hack. Never silently defaults.

_oc_modes=(corp hack)

oc() {
  emulate -L zsh
  setopt local_options no_nomatch

  local root pin arg="${1:-}" mode=""
  root="$(git rev-parse --show-toplevel 2>/dev/null)"
  if [[ -n "$root" && -r "$root/.ocmode" ]]; then
    pin="$(tr -d '[:space:]' < "$root/.ocmode")"
  fi

  if [[ -n "$pin" ]]; then
    # Refuse only a *different known mode*; any other first arg (a subcommand,
    # flag, or prompt like `run`, `--help`, `-m ...`) is forwarded to opencode.
    if [[ -n "$arg" ]] && (( ${_oc_modes[(Ie)$arg]} )) && [[ "$arg" != "$pin" ]]; then
      print -u2 "oc: repo is pinned to '$pin'; refusing to launch as '$arg'."
      return 1
    fi
    mode="$pin"
    # Consume the arg only when it is the pin name itself; otherwise forward it.
    [[ "$arg" == "$pin" ]] && shift
  elif [[ -n "$arg" ]] && (( ${_oc_modes[(Ie)$arg]} )); then
    mode="$arg"; shift
  elif [[ -n "$arg" ]]; then
    print -u2 "oc: unknown mode '$arg' (expected: ${_oc_modes[*]})."
    return 1
  else
    print -u2 "oc: no mode pinned or given. Choose one:"
    local PS3="mode> " choice
    select choice in $_oc_modes; do
      [[ -n "$choice" ]] && { mode="$choice"; break; }
    done
    [[ -z "$mode" ]] && { print -u2 "oc: no mode selected."; return 1; }
  fi

  local dir="$HOME/.config/opencode/profiles/$mode"
  if [[ ! -r "$dir/opencode.json" ]]; then
    print -u2 "oc: profile not found: $dir/opencode.json"
    return 1
  fi

  print -u2 "oc: launching in '$mode' mode."
  OPENCODE_CONFIG="$dir/opencode.json" OPENCODE_CONFIG_DIR="$dir" command opencode "$@"
}
