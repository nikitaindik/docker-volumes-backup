#!/bin/bash

function should_remove_file {
  regex="[0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]_([0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])\.zip"

  if [[ $1 =~ $regex ]]
  then
    if [ "${BASH_REMATCH[1]}" -lt $oldest_possible_backup_timestamp ]
    then
        return 1
    fi    
  fi

  return 0
}

function remove_file_in_dropbox {
    ./dropbox_uploader.sh -f .dropbox_uploader delete "/$1"
}

# 604800 is 7 days
backup_lifetime=604800
current_timestamp=($(date +"%s"))
oldest_possible_backup_timestamp=`expr $current_timestamp - $backup_lifetime`

list_result=$(/home/docker_volumes_backup_app/dropbox_uploader.sh -q -f .dropbox_uploader list)

readarray rows <<< $list_result

filenames_to_delete=()

for row in "${rows[@]}";do
  row_array=(${row})
  filename=${row_array[2]}

  should_remove_file $filename

  if [ $? = 1 ]; then
    filenames_to_delete+=($filename)
  fi
done

for filename_to_delete in "${filenames_to_delete[@]}"
do
  remove_file_in_dropbox $filename_to_delete
done
