#!/bin/bash
# Install CUDA driver on Ubuntu 16.04

driver=cuda-9-1

function usage {
	echo "Usage: $0 [8|9|10|purge]"
	echo " install $driver by default"
	echo " 8 - install cuda-8-0"
	echo " 9 - install cuda-9-0"
	echo " 10 - install cuda-9-0"
	echo " purge - uninstall cuda driver"
	exit 64
}

function install_driver {
	cuda_pkg="$1"
	nvidia_key=https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
	cuda_repo_url=http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_10.1.105-1_amd64.deb

	cuda_repo_pkg=${cuda_repo_url##*/}
	wget -qO - "$nvidia_key" | apt-key add - 
	curl -O "$cuda_repo_url" && dpkg -i "$cuda_repo_pkg" && apt-get update && apt-get install -y nvidia-418 "$cuda_pkg"

	if [[ "$?" -eq 0 ]]; then
		echo "Installing CUDA toolkit (${cuda_pkg}): Succeded !"
	else
		echo "Installing CUDA toolkit (${cuda_pkg}): Failed !"
		exit 1
	fi
}

function purge_driver {
			apt-get --purge remove \*cuda\*
			apt-get --purge remove \*nvidia\*
			exit
}

function check_root {
	if [[ $EUID -ne 0 ]]; then
		echo "Error: need to be run as root" 
		exit 1
	fi
}

function check_gpu {
	lspci | grep -q NVIDIA
	if [[ $? -ne 0 ]]; then
		echo "Error: no NVIDIA GPU on this machine"
		exit 1
	fi
}

# Main

check_root
check_gpu

if [[ $# -ne 0 ]]; then
	case "$1" in
		10)
			driver=cuda-10-0
			;;
		9)
			driver=cuda-9-0
			;;
		8)
			driver=cuda-8-0
			;;
		purge)
			echo "Removing CUDA toolkit, it should take about 10 min ..."
			purge_driver
			exit 1
			;;
		*)
			usage
			;;
	esac
fi

echo "Installing CUDA toolkit ($driver), it should take about 10 min ..."
install_driver $driver
exit 0
