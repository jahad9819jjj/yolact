image_name="yolact/py3_cu110_torch071"

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

# nvidia-docker build -t $image_name $@ .
$DOCKER build -t $image_name $@ .

mkdir -p "bck_img/${image_name}"
docker save $image_name > "bck_img/${image_name}_$(date '+%Y%m%d').tar"