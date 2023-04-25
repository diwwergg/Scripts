# Script for install CUDA and Tensorflow in WSL2 Ubuntu 20.04
echo "Install CUDA and Tensorflow in WSL2 Ubuntu 20.04"
sudo apt update && sudo apt upgrade

# Install Anaconda shell script
wget https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh 
sudo bash Anaconda3-2023.03-Linux-x86_64.sh
rm -rf Anaconda3-2022.10-Linux-x86_64.sh

#  Installing CUDA and cuDNN drivers for WSL2
sudo sudo apt-key del 7fa2af80
sudo apt update && sudo apt upgrade

# Next, download and move the CUDA Ubuntu repository pin to the relevant destination and download new sign keys:
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/7fa2af80.pub


# Then, download the WSL2 CUDA Toolkit repository (it will take a while):
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/ /"
sudo apt update && sudo apt upgrade


# Install CUDA
sudo apt-get -y install cuda
sudo apt update && sudo apt upgrade


sudo apt-get install libcudnn8
sudo apt-get install libcudnn8-dev
sudo apt-get update && sudo apt-get upgrade

# Install TensorFlow inside a conda environment
conda create -n tf python=3.9 -y
conda activate tf

pip install tensorflow
pip install tensorflow-gpu
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

# Show massage success
echo "Install CUDA and Tensorflow success"