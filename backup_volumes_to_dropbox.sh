#!/bin/bash

cd /home/docker_volumes_backup_app

formatted_date=$(date +"%d-%m-%Y_%s")
zip_filename="${formatted_date}.zip"

zip -r ${zip_filename} host_volumes/*

./dropbox_uploader.sh -f .dropbox_uploader upload ${zip_filename} /