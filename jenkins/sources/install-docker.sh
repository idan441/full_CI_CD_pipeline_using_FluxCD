#This script will install docker on the local machine. 
#This script needs ot be run from the local VM in order to install docker on it. 



#Update apt-get and do pre-configurations. 
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common


#Add docker repository and install docker. 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce


#Test
echo "docker is installed. " 
sudo systemctl status docker
