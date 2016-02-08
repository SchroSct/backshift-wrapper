#!/bin/bash
if [ -z "$3" ]
then
   echo "Usage: backshift-backup.sh /source/files/location/ /backshift/backup/location name"
fi
sdir="$1"
bdir="$2"
name="$3"
find "$sdir" -xdev -print0 | backshift --save-directory "$bdir" --backup --subset "$name" --progress-report minimal
