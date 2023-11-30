username="$USER"

path_host="/home/$username/Workspaces/custom_yolact" 
path_docker="/workspace"

# container variables
container_name="${username}_yolact_py3"
image_name=yolact/py3_cu110_torch071
shm_size="8192m"
GPUs=0

# choose docker or nvidia-docker
exist_docker='/usr/bin/docker'
exist_nvdocker='/usr/bin/nvidia-docker'

if [ -e $exist_nvdocker ]; then
    DOCKER=nvidia-docker
else
    if [ -e $exist_docker ]; then
        DOCKER=docker
    else
        echo
    fi
fi

if [ "$(docker ps -qa -f name=${container_name})" ]; then
  echo "Exist: ${container_name}"

  if [ "$(docker ps -aq -f status=running -f name=${container_name})" ]; then
    echo "Status: Running"
    docker exec -it ${container_name} bash
  else
    echo "Status: "
    docker start ${container_name}
    docker attach ${container_name}
  fi
else
  echo "Not Exist: ${container_name}"
$DOCKER run --rm -it --gpus ${GPUs} --shm-size=${shm_size} -v "${path_host}:${path_docker}" --name ${container_name} ${image_name} bash
fi