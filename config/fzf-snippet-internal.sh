#!/bin/bash
# This script runs INSIDE the 'main' container

# Path to the snippet file (same path as host)
SNIPPET_FILE="$HOME/.config/snippets.txt"

# 1. Cat the file
# 2. Pipe to fzf with a preview
# 3. Cut the line to get only the value (after the '|')
# 4. Trim leading whitespace
# 5. If a selection was made, copy it to the clipboard
SELECTED=$(cat "$SNIPPET_FILE" | \
    fzf --height=40% --layout=reverse \
    --preview="echo {} | cut -d '|' -f 2- | sed 's/^[ \t]*//'" \
    --preview-window="top:3:wrap" | \
    cut -d '|' -f 2- | \
    sed 's/^[ \t]*//')

if [[ -n "$SELECTED" ]]; then
    echo -n "$SELECTED" | wl-copy
fi