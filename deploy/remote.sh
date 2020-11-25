docker load --input ${image_name}.tar

running_container_id=`docker container ls -aqf name=${image_name}`

if [[ ! -z "$running_container_id" ]]
then
    docker container stop $running_container_id
    docker container rm $running_container_id
fi

./run-${image_name}.sh