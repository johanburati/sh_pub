#!/bin/bash
# Install CUDA driver on Ubuntu 16.04

# Set cuda_pkg to install a different version
cuda_pkg=cuda-9-1
#cuda_pkg=cuda-9-0
#cuda_pkg=cuda-8-0

nvidia_key=https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
cuda_repo_url=http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.1.85-1_amd64.deb

if [[ $EUID -ne 0 ]]; then
  echo "Error: need to be run as root" 
  exit 1
fi

lspci | grep -q NVIDIA
if [[ $? -ne 0 ]]; then
  echo "Error: no NVIDIA GPU on this machine"
  exit 1
fi

echo "Installing CUDA toolkit (${cuda_pkg}), it should take about 10 min ..."
cuda_repo_pkg=${cuda_repo_url##*/}
wget -qO - "$nvidia_key" | apt-key add - 
curl -O "$cuda_repo_url" && dpkg -i "$cuda_repo_pkg" && apt-get update && apt-get install -y "$cuda_pkg"

if [[ "$?" -eq 0 ]]; then
  echo "Installing CUDA toolkit (${cuda_pkg}): Succeded !"
else
  echo "Installing CUDA toolkit (${cuda_pkg}): Failed !"
  exit 1
fi

exit 0
