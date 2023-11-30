FROM nvidia/cuda:11.0.3-cudnn8-devel-ubuntu18.04

ENV CUDA_PATH=/usr/local/cuda
ENV PATH=$CUDA_PATH/bin:/usr/local/bin:$PATH
ENV CPATH=$CUDA_PATH/include:/usr/local/include:$CPATH
ENV LD_LIBRARY_PATH=$CUDA_PATH/lib64:$CUDA_PATH/lib:/usr/local/lib:$LD_LIBRARY_PATH

ENV DEBIAN_FRONTEND=noninteractive

RUN rm /etc/apt/sources.list.d/cuda.list
# RUN rm /etc/apt/sources.list.d/nvidia-ml.list

RUN apt update
RUN apt install -y --no-install-recommends \
    apt-utils \
    python3 python3-dev python3-pip \
    default-libmysqlclient-dev \
    build-essential \
    git vim curl \
    libopencv-dev \
    cifs-utils \
    rsync \
    wget ca-certificates \
    software-properties-common 
RUN apt-get -y clean
RUN apt-get install -y locales \
  && locale-gen ja_JP.UTF-8

  RUN pip3 install --upgrade pip setuptools --trusted-host pypi.python.org

RUN pip install \
  torch==1.7.1+cu110 \
  torchvision==0.8.2+cu110 \
  torchaudio==0.7.2 \
  -f https://download.pytorch.org/whl/cu110/torch_stable.html \
  --no-cache-dir \
  && pip install torchsummary --no-cache-dir

RUN pip install scikit-image
RUN pip install opencv-python pillow pycocotools PyQt5 IPython

WORKDIR /workspace