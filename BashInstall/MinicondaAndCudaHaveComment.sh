# Download the CUDA repository pin file
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin

# Move the pin file to the appropriate location
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600

# Download the CUDA repository installer
wget https://developer.download.nvidia.com/compute/cuda/12.1.1/local_installers/cuda-repo-wsl-ubuntu-12-1-local_12.1.1-1_amd64.deb

# Install the CUDA repository
sudo dpkg -i cuda-repo-wsl-ubuntu-12-1-local_12.1.1-1_amd64.deb

# Copy the CUDA keyring files to the appropriate location
sudo cp /var/cuda-repo-wsl-ubuntu-12-1-local/cuda-*-keyring.gpg /usr/share/keyrings/

# Update the package list
sudo apt-get update

# Install CUDA
sudo apt-get -y install cuda

# Download the latest version of Miniconda
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o Miniconda3-latest-Linux-x86_64.sh

# Run the Miniconda installer
bash Miniconda3-latest-Linux-x86_64.sh

# Update the shell environment
source ~/.bashrc

# Create a new Conda environment for TensorFlow
conda create --name tf python=3.9

# Deactivate the current Conda environment
conda deactivate

# Activate the new Conda environment for TensorFlow
conda activate tf

# Check for NVIDIA GPUs using the nvidia-smi command
nvidia-smi

# Install the specified version of CUDA Toolkit using Conda
conda install -c conda-forge cudatoolkit=11.8.0

# Install the specified version of cuDNN using pip
pip install nvidia-cudnn-cu11==8.6.0.163

# Get the path of the installed cuDNN library
CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))

# Set the LD_LIBRARY_PATH environment variable to include the cuDNN library path
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib

# Create an activation script for the Conda environment that sets the LD_LIBRARY_PATH variable
mkdir -p $CONDA_PREFIX/etc/conda/activate.d
echo 'CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh

# Upgrade pip
pip install --upgrade pip

# Install TensorFlow 2.12 using pip
pip install tensorflow==2.12.*

# Verify that TensorFlow is installed and running on the GPU
python3 -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

# Print a message indicating that the setup is complete
echo "Setup complete!"
