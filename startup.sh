#!/bin/bash
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo rm -rf /usr/share/keyrings/docker-archive-keyring.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER


## setup project folder


## install kubernates right

sudo apt-get update -y && sudo apt-get install -y apt-transport-https gnupg2 curl

git clone https://github.com/HosHaggag/gke-infra-using-terraform.git

sudo snap remove google-cloud-cli 


curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-451.0.1-linux-x86_64.tar.gz

tar zxvf google-cloud-cli-451.0.1-linux-x86_64.tar.gz

./google-cloud-sdk/install.sh

source ~/.bashrc

gcloud components install kubectl --quiet

gcloud container clusters get-credentials workload-cluster \
    --region=us-east1 \
    --project=gcp-iti-401020

gcloud config set project gcp-iti-401020

gcloud config set compute/zone us-central1-a






gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  us-central1-docker.pkg.dev

sudo docker build -t nodejs-app .


sudo docker build -t mongodb .



## tag docker image

sudo docker tag simple-node-app us-central1-docker.pkg.dev/gcp-iti-401020/my-nodejs-repo/simple-node-app:1.0.0


sudo docker push us-central1-docker.pkg.dev/gcp-iti-401020/my-nodejs-repo/simple-node-app:1.0.0





kubectl exec -it pod/mongo-0 mongosh


rs.initiate(
   {
      _id: "rs0",
      version: 1,
      members: [
         { _id: 0, host : "mongo-0.mongo.default.svc.cluster.local:27017" },
         { _id: 1, host : "mongo-1.mongo.default.svc.cluster.local:27017" },
         { _id: 2, host : "mongo-2.mongo.default.svc.cluster.local:27017" }
      ]
   }
)

use admin

db.createUser(
         {
           user: "admin",
           pwd: "password",
           roles: [
             { role: "readWrite" , db: "admin" }
           ]
         }
       );
       




