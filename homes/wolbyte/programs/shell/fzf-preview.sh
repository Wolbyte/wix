FILE=${1/#\~\//$HOME/}

if [[ ! "$FILE" ]]; then
  exit
fi

TYPE=$(file -Lbi "$FILE")

preview_dim="${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}"
if [[ "$preview_dim" = "x" ]]; then
  preview_dim=$(stty size </dev/tty | awk '{print $2 "x" $1}')
fi

if [[ "$TYPE" =~ "/directory" ]]; then
  eza -1 --icons=always --color=always "$FILE"
  exit
fi

if [[ ! "$TYPE" =~ "image/" ]]; then
  if [[ "$TYPE" =~ "=binary" ]]; then
    file "$FILE"
    exit
  fi

  bat --color=always --style=numbers --pager=never --line-range=:500 --highlight-line="0:-0" "$FILE"
  exit
fi

if [[ "$TYPE" =~ "image/" ]] && [[ $KITTY_WINDOW_ID ]] && command -v kitten >/dev/null; then
  kitten icat --clear --transfer-mode=memory --unicode-placeholder --stdin=no --place="$preview_dim@0x0" "$FILE"
  exit
else
  # Cannot display image
  file $FILE
  exit
fi
