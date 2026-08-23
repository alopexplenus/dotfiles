#!/usr/bin/env bash
# Tests the toggle state machine with stubbed pw-record/whisper-cli/xdotool.
set -eu
DOT="${DOT:-$(cd "$(dirname "$0")/../../.." && pwd)}"
WORK="$(mktemp -d)"; BIN="$WORK/bin"; mkdir -p "$BIN"
export XDG_RUNTIME_DIR="$WORK/run"; mkdir -p "$XDG_RUNTIME_DIR"
export HOME="$WORK/home"; mkdir -p "$HOME"   # hermetic: real ~/.config/voice/config never leaks in

# stub pw-record: long-running so it can be killed
cat > "$BIN/pw-record" <<'EOF'
#!/usr/bin/env bash
# last arg is the wav path; create it, then sleep
for a in "$@"; do wav="$a"; done
: > "$wav"; exec sleep 60
EOF
# stub whisper-cli: write "<of>.txt" with fixed text
cat > "$BIN/whisper-cli" <<'EOF'
#!/usr/bin/env bash
of=""; while [ $# -gt 0 ]; do [ "$1" = "-of" ] && { of="$2"; shift; }; shift; done
printf 'hello world' > "$of.txt"
EOF
# stub xdotool: record what would be typed
cat > "$BIN/xdotool" <<'EOF'
#!/usr/bin/env bash
shift $(( $# - 1 )); printf '%s' "$1" > "$XDG_RUNTIME_DIR/typed.txt"
EOF
chmod +x "$BIN"/*
export PATH="$BIN:$PATH"

# env overrides win; the script finds no config file under the hermetic HOME
export WHISPER_BIN="$BIN/whisper-cli"
mkdir -p "$WORK/models"; : > "$WORK/models/ggml-small.en.bin"
export WHISPER_MODELS_DIR="$WORK/models"

TOGGLE="$DOT/.local/bin/voice-toggle"
fail=0
# First press: start recording -> pidfile exists
"$TOGGLE"
if [ -f "$XDG_RUNTIME_DIR/voice/rec.pid" ]; then echo "ok: recording started"; else echo "FAIL: no pidfile"; fail=1; fi
# Second press: stop + transcribe + type
"$TOGGLE"
typed="$(cat "$XDG_RUNTIME_DIR/typed.txt" 2>/dev/null || true)"
if [ "$typed" = "hello world" ]; then echo "ok: typed transcript"; else echo "FAIL: typed='$typed'"; fail=1; fi
exit $fail
