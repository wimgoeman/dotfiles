function scpjmppull
  if [ -z "$JUMP_SERVER" ]
    echo "No \$JUMP_SERVER configured!"
    return 1
  end
  set -x TERM xterm
  scp gu=pwgoeman@pwgoeman@$argv[1]@$JUMP_SERVER:$argv[2] $argv[3]
end

