echo "UPDATING AND UPGRADING..."
sudo apt-get update
sudo apt-get upgrade -y
echo "INSTALLING DOCKER..."
## docker install
curl -fsSL https://get.docker.com | sh
echo "DOCKER ISNTALLED..."

sudo usermod -aG docker pi
echo "pi user added to group docker!"
## install docker-compose
echo "INSTALLING DOCKER-COMPOSE..."
sudo apt-get install libffi-dev libssl-dev -y
sudo apt install python3-dev -y
sudo apt-get install python3 python3-pip -y

##reboot
sudo python3 -m pip install docker-compose

sudo systemctl enable docker
echo "DOCKER-COMPOSE INSTALLED!"

