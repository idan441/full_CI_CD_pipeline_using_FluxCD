#!/bin/bash

#This script will push images to Google Container Registry. (GCR) 
#The image name will be taken from a file named image_name which is located in the jenkins-scripts directory. This file is created by the build_image.sh script at the build stage. 

image_name=$(cat image_name) #The image name consist of the application name + tag. 
docker push ${image_name}

echo "finished pushing the image"
