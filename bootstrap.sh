#!/usr/bin/env bash

# Update Repositories
sudo apt-get update
sudo apt-get autoremove -y

# Determine Ubuntu Version
. /etc/lsb-release

# Decide on package to install for `add-apt-repository` command
#
# USE_COMMON=1 when using a distribution over 12.04
# USE_COMMON=0 when using a distribution at 12.04 or older
USE_COMMON=$(echo "$DISTRIB_RELEASE > 12.04" | bc)

if [ "$USE_COMMON" -eq "1" ];
then
    sudo apt-get install -y software-properties-common
else
    sudo apt-get install -y python-software-properties
fi

# Add Ansible Repository & Install Ansible
sudo add-apt-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

# Setup Ansible for Local Use and Run
cp /vagrant/ansible/inventories/dev /etc/ansible/hosts -f
chmod 666 /etc/ansible/hosts
cat /vagrant/ansible/files/authorized_keys >> /home/vagrant/.ssh/authorized_keys
sudo ansible-playbook /vagrant/ansible/playbook.yml -e hostname=$1 --connection=local

# Create folder to track updates
if [ ! -d /home/vagrant/.vagrant ]; then
    sudo -u vagrant mkdir /home/vagrant/.vagrant
    # create necessary symlinks to vagrant root
    ln -s /vagrant/menu.sh /home/vagrant/menu.sh
fi

# Install php5-cgi
if [ ! -f /home/vagrant/.vagrant/php5-cgi ]; then
    sudo apt-get -y install php5-cgi
    touch /home/vagrant/.vagrant/php5-cgi
fi

# Install Git 2.0
if [ ! -f /home/vagrant/.vagrant/git ]; then
    echo 'Installing GIT'
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt-get -y install git
    touch /home/vagrant/.vagrant/git
fi

# Install Mysql
if [ ! -f /home/vagrant/.vagrant/mysql ]; then
    echo 'Installing Mysql'
    sudo apt-get install mysql-server
    touch /home/vagrant/.vagrant/mysql
fi

# Download and extract gcloud
if [ ! -f /home/vagrant/.vagrant/gcloud ]; then
    echo 'Installing gcloud'
    mkdir /home/vagrant/appengine/
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-141.0.0-linux-x86_64.tar.gz -P /home/vagrant/appengine/
    cd /home/vagrant/appengine/
    tar -zxvf google-cloud-sdk-141.0.0-linux-x86_64.tar.gz
    sudo chmod 777 -R  google-cloud-sdk/
    touch /home/vagrant/.vagrant/gcloud
fi

GREEN='\033[1;32m'
echo -e "\n ${GREEN}test connection at 192.168.33.99"




