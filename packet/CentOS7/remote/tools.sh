#/bin/bash
set -e
yum update -y
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
  LATEST_URL=$(curl -sL https://releases.hashicorp.com/vagrant/index.json | jq -r '.versions[].builds[].url' | egrep 'vagrant_[0-9]\.[0-9]{1,2}\.[0-9]{1,2}_x86_64.rpm' | sort -V | tail -1)
  curl ${LATEST_URL} > /tmp/vagrant.rpm
  (cd /tmp && yum -y localinstall vagrant.rpm)

  echo "Installed: `vagrant version`"
}

function packer-install() {
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

# Install VirtualBox
wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo -P /etc/yum.repos.d/
yum -y install VirtualBox-6.0


#Install vagrant
vagrant-install
# Install Packer
packer-install
# Install Terraform
terraform-install
# Reload PATH
source_reload

# Install Nomad
mkdir ${HOME}/nomad && cp /tmp/Vagrantfile ${HOME}/nomad && cd ${HOME}/nomad
vagrant up
