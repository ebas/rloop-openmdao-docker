#!/bin/bash
set -e

sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list 
apt-get update 
apt-get -y upgrade 
apt-get install -y  \
    build-essential \
    software-properties-common \
    pkg-config byobu curl git htop man unzip vim wget gfortran \
    python python-dev python-pip libfreetype6-dev g++ scons libboost-all-dev \
    libsundials-serial-dev python-numpy python-scipy python-matplotlib 

# Cantera
cd /root/ 
git clone https://github.com/Cantera/cantera.git 
cd cantera 
git checkout 2.1 
scons build -j4 blas_lapack_libs=lapack,blas 
scons install 
source /usr/local/bin/setup_cantera

# openmdao
cd /root/ 
wget http://openmdao.org/releases/0.10.3.2/go-openmdao-0.10.3.2.py
python go-openmdao-0.10.3.2.py 
cd /root/openmdao-0.10.3.2 
source bin/activate

# pyCycle 
cd /root/ 
git clone https://github.com/OpenMDAO-Plugins/pyCycle.git 
cd pyCycle 
python setup.py develop 

# Hyperloop
cd /root/
git clone https://github.com/OpenMDAO-Plugins/Hyperloop.git
cd Hyperloop
python setup.py develop

echo 'source ~/openmdao-0.10.3.2/bin/activate' >> ~/.bashrc
echo 'cd Hyperloop/src/hyperloop' >> ~/.bashrc
