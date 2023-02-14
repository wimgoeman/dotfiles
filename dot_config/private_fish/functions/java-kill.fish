function java-kill
   set JK_PATTER $argv[1]
   set JK_TMP_FILE /tmp/grepped-ps
   
   jcmd | grep -E $argv[1] > $JK_TMP_FILE
   set JK_LINES (cat $JK_TMP_FILE | wc -l)
   if [ $JK_LINES -eq 0 ] 
     echo "No mathing process not found"
   else if [ $JK_LINES -gt 1 ] 
     echo "More than 1 matching process found. Kill it manually."
     cat $JK_TMP_FILE
   else if [ $JK_LINES -eq 1 ]
     set JK_PID (cat $JK_TMP_FILE | cut -d ' ' -f1)
     echo "Killing $JK_PID"
     kill -9 $JK_PID
   end
   rm $JK_TMP_FILE
end 
