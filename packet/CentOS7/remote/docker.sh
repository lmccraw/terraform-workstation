#/bin/bash
set -e

# Install docker
sudo yum check-update
curl -fsSL https://get.docker.com/ | sh
sudo systemctl start docker
sudo systemctl status docker
sudo systemctl enable docker

#Executing Docker without sudo
sudo usermod -aG docker $(whoami)

#Test Docker
sudo docker run hello-world

# Install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
