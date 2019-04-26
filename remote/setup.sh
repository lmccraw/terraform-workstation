#/bin/bash
set -e

# Get latest version Fucntions

function terraform-install() {
  [[ -f ${HOME}/bin/terraform ]] && echo "`${HOME}/bin/terraform version` already installed at ${HOME}/bin/terraform" && return 0
  LATEST_URL=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].url' | egrep 'terraform_[0-9]\.[0-9]{1,2}\.[0-9]{1,2}_linux.*amd64' | sort -V | tail -1)
  curl ${LATEST_URL} > /tmp/terraform.zip
  mkdir -p ${HOME}/bin
  (cd ${HOME}/bin && unzip /tmp/terraform.zip)
  if [[ -z $(grep 'export PATH=${HOME}/bin:${PATH}' ~/.bashrc) ]]; then
  	echo 'export PATH=${HOME}/bin:${PATH}' >> ~/.bashrc
  fi

  echo "Installed: `${HOME}/bin/terraform version`"
}

function vagrant-install() {
  [[ -f ${HOME}/bin/vagrant ]] && echo "`${HOME}/bin/vagrant version` already installed at ${HOME}/bin/vagrant" && return 0
  LATEST_URL=$(curl -sL https://releases.hashicorp.com/vagrant/index.json | jq -r '.versions[].builds[].url' | egrep 'vagrant_[0-9]\.[0-9]{1,2}\.[0-9]{1,2}_linux.*amd64' | sort -V | tail -1)
  curl ${LATEST_URL} > /tmp/vagrant.zip
  mkdir -p ${HOME}/bin
  (cd ${HOME}/bin && unzip /tmp/vagrant.zip)
  if [[ -z $(grep 'export PATH=${HOME}/bin:${PATH}' ~/.bashrc) ]]; then
  	echo 'export PATH=${HOME}/bin:${PATH}' >> ~/.bashrc
  fi

  echo "Installed: `${HOME}/bin/vagrant version`"
}

function vagrant-install() {
  [[ -f ${HOME}/bin/packer ]] && echo "`${HOME}/bin/packer version` already installed at ${HOME}/bin/packer" && return 0
  LATEST_URL=$(curl -sL https://releases.hashicorp.com/packer/index.json | jq -r '.versions[].builds[].url' | egrep 'packer_[0-9]\.[0-9]{1,2}\.[0-9]{1,2}_linux.*amd64' | sort -V | tail -1)
  curl ${LATEST_URL} > /tmp/packer.zip
  mkdir -p ${HOME}/bin
  (cd ${HOME}/bin && unzip /tmp/packer.zip)
  if [[ -z $(grep 'export PATH=${HOME}/bin:${PATH}' ~/.bashrc) ]]; then
  	echo 'export PATH=${HOME}/bin:${PATH}' >> ~/.bashrc
  fi

  echo "Installed: `${HOME}/bin/packer version`"
}

function source_reload() {
  source ~/.bashrc
}

# Base Yum Operations
yum update -y
declare -a yumlist=(binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms jq mlocate unzip)
yum install -y ${yumlist[@]}
updatedb

# Install VirtualBox
cd /etc/yum.repos.d/
wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install VirtualBox-6.0 -y

#Install vagrant
vagrant-install
# Install Packer
packer-install
# Install Terraform
terraform-install
# Reload PATH
source_reload