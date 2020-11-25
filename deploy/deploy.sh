#!/bin/bash

source .deploy

docker save --output $image_name.tar $image_name

scp $image_name.tar $ssh_connection:$remote_directory
rm $image_name.tar

(echo image_name=$image_name ; cat remote.sh) > remote_script.sh
scp remote_script.sh $ssh_connection:$remote_directory
rm remote_script.sh

ssh $ssh_connection "bash remote_script.sh && rm remote_script.sh"