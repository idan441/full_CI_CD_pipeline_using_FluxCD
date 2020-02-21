# A backup of the Jenkisfile set on the echo application GitHub repository - 
This folder contains the copy of the files which are used in the Jenkins multi-branch pipeline for the echo application! 

In order to make a branch to execute the Jenkinsfile put the Jenkinsfile at it's root directory. Also make sure to copy the jenkins_scripts directory and locate in under the root directory! 


* For further instructions please see the ./Jenkins/README.md file. ( The general file informing about the Jenkins configuration in this project. ) 



## The Jenkinsfile - 
In order to make a branch to be used by Jenkin's Multi-branch pipeline - you need to do the following - 
0. Configure the 3 fields at the Jenkinsfile. 
1. Copy the Jenkinsfile to the root directory of the branch. ( This file will be located when Jenkins will scan the GitHub repository. ) 
2. Copy the jenkins_scripts directory - and place it under the root directory. The directory includes 3 files. ( These files will be used by the Jenkinsfile. ) 
3. Remember - these files need to be on every branch! When updating the Jenkinsfile and ocmmiting the chnages - the commit happens just on the local branch. You need to copy the updated file to all the branches! 

* I attached a copy of these files under the directory "backup-jenkinsfile" , but remember they need to be on the application repository! ( At https://github.com/idan441/echoapp . ) 
