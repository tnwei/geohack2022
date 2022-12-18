# Download and install Mambaforge first before following the rest of the script
# bash <installer.sh>

# Set up the base environment that will house Jupyter Lab
conda activate base
mamba install jupyterlab notebook nb_conda_kernels

# Set up the Pytorch environment following official docs, and install additional libs
conda create --name py36_pytorch python=3.6
conda activate py36_pytorch
mamba install pytorch torchvision torchaudio pytorch-cuda=11.7 -c pytorch -c nvidia -y
mamba install ipykernel pandas numpy matplotlib einops tqdm scipy scikit-learn lightgbm ipywidgets xgboost pip -y
pip install pyzgy lasio

# Set up the Tensorflow environment following official docs, and install additional libs
conda create --name py37_tensorflow python=3.7
conda activate py37_tensorflow
mamba install -c conda-forge cudatoolkit=11.2 cudnn=8.1.0 -y
mamba install ipykernel pandas numpy matplotlib einops tqdm scipy scikit-learn lightgbm ipywidgets xgboost pip -y
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
mkdir -p $CONDA_PREFIX/etc/conda/activate.d
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/' > $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
echo 'LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/' >> .bashrc
pip install tensorflow
pip install pyzgy lasio

# Test both environments
conda activate py36_pytorch
python -c "import torch; print(torch.cuda.is_available())"
conda activate py37_tensorflow
python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
