function sshjmp
  if [ -z "$JUMP_SERVER" ]
    echo "No \$JUMP_SERVER configured!"
    return 1
  end
  set -x TERM xterm
  ssh gu=pwgoeman@pwgoeman@$argv[1]@$JUMP_SERVER
end

