FROM arm32v7/alpine

RUN apk update && apk add bash curl zip

COPY backup_volumes_to_dropbox.sh /etc/periodic/daily/1_backup_volumes_to_dropbox
RUN chmod +x /etc/periodic/daily/1_backup_volumes_to_dropbox

COPY remove_old_volume_backups.sh /etc/periodic/daily/2_remove_old_volume_backups
RUN chmod +x /etc/periodic/daily/2_remove_old_volume_backups

WORKDIR /home/docker_volumes_backup_app

COPY .dropbox_uploader .
COPY dropbox_uploader.sh .
COPY docker_entrypoint.sh .

ENTRYPOINT ["/bin/bash", "docker_entrypoint.sh"]