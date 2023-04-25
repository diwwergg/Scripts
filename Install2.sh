#!/bin/bash

# Update package repository and upgrade existing packages
echo "Updating packages..."
sudo apt update && sudo apt upgrade -y

# Download and install Anaconda
echo "Installing Anaconda..."
wget https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh 
sudo bash Anaconda3-2023.03-Linux-x86_64.sh -b -p $HOME/anaconda3
rm Anaconda3-2023.03-Linux-x86_64.sh

# Add Anaconda to PATH
echo "Adding Anaconda to PATH..."
echo 'export PATH="$HOME/anaconda3/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Download and install CUDA and cuDNN drivers for WSL2
echo "Installing CUDA and cuDNN drivers..."
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/3bf863cc.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/ /"
sudo apt update && sudo apt upgrade -y
sudo apt-get -y install cuda libcudnn8 libcudnn8-dev

# Create a new conda environment and install TensorFlow
echo "Creating conda environment and installing TensorFlow..."
conda create -n tf python=3.9 -y
conda activate tf
pip install tensorflow tensorflow-gpu
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

# Show success message
echo "Installation of CUDA and TensorFlow completed successfully."
