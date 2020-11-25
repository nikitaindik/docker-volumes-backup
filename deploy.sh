#!/bin/bash

source .deploy

docker save --output $image_name.tar $image_name

scp $image_name.tar $ssh_connection:$remote_directory

rm $image_name.tar

ssh $ssh_connection "docker load --input ${image_name}.tar"

# docker container ls -aqf "${image_name}"