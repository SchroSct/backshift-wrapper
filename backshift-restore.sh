#!/bin/bash
bsdir="$1"
select opt in $(backshift --save-directory "$bsdir" --list-backups | awk ' { if ($4 != "None") print }' | sort | sed -e 's/ .*//g')
do
   echo "You chose $opt"
   echo "Where would you like to restore to?"
   read respath
   if [ -d "$respath" ]
   then
      echo "$respath exists, restoring."
      if cd "$respath"
      then
         backshift --save-directory "$bsdir" --backup-id "$opt" --produce-tar | tar xvf -
      else
         echo "Could not enter $respath"
      fi
   else
      echo "$respath does not exist, creating."
      mkdir "$respath"
      if cd "$respath"
      then
         backshift --save-directory "$bsdir" --backup-id "$opt" --produce-tar | tar xvf -
      else
         echo "Could not enter $respath"
      fi
   fi
break
done
