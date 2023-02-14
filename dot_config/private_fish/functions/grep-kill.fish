function grep-kill
   set GK_PATTER $argv[1]
   set GK_TMP_FILE /tmp/grepped-ps
   
   ps aux | grep -E $argv[1] | grep -v grep > $GK_TMP_FILE
   set GK_LINES (cat $GK_TMP_FILE | wc -l)
   if [ $GK_LINES -eq 0 ] 
     echo "No mathing process not found"
   else if [ $GK_LINES -gt 1 ] 
     echo "More than 1 matching process found. Kill it manually."
     cat $GK_TMP_FILE
   else if [ $GK_LINES -eq 1 ]
     set GK_PID (cat $GK_TMP_FILE | tr -s ' ' | cut -d ' ' -f 2)
     echo "Killing $GK_PID"
     kill -9 $GK_PID
   end
   rm $GK_TMP_FILE
end 
