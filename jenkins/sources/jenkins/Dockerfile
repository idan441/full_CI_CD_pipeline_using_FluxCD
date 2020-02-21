FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get install -y python3-pip && apt-get install -y jq
RUN curl -sSL https://get.docker.com/ | sh
RUN usermod -aG docker jenkins
ENV DOCKER_HOST unix:///var/run/docker.sock
# USER jenkins

#Install Gcloud authenticator
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get install apt-transport-https ca-certificates gnupg
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update -y && apt-get install google-cloud-sdk -y


# install aws
USER root
RUN apt-get update
RUN apt install python3-pip -y
RUN pip3 install awscli --upgrade
# install terraform
RUN apt-get install unzip
RUN wget https://releases.hashicorp.com/terraform/0.12.19/terraform_0.12.19_linux_amd64.zip
RUN unzip terraform_0.12.19_linux_amd64.zip
RUN mv terraform /usr/local/bin/
# install ansible
RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt-get update
RUN echo 'Y' | apt-get install ansible
# install nano
RUN apt-get install nano
USER jenkins