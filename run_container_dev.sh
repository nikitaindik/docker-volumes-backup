docker run -it \
    --init \
    -d \
    -v ${PWD}/test_volumes:/home/docker_volumes_backup_app/host_volumes \
    --name docker-volumes-backup-container \
    docker-volumes-backup