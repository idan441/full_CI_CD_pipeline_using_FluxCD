#This script will install docker-compose on the local machine. 
#This script should be ran on the Jenkins VM in order to be able to run the docker-compose.yaml file running Jenkins. 

#Please run this script, after the installation of docker. 
#This script was tested as compatible in Ubuntu 18.04 OS. 


#Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#Optional - add auto-completion. ( This is not a must, though might be useful... ) 
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


#Test
echo "finished installing docker-compose"
docker-compose --version 

