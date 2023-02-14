function tacit
  set targetfile $argv[1].tac
  tac $argv[1] > $targetfile
  rm $argv[1]
  mv $targetfile $argv[1]
end
