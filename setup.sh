#!/bin/bash

# Update all software packages
sudo yum update -y

# Install necessary software (e.g., curl, git, Java)
sudo amazon-linux-extras install java-openjdk11 -y

# Download and unpack NiFi
cd /opt
sudo wget https://dlcdn.apache.org/nifi/1.21.0/nifi-1.21.0-bin.zip
sudo unzip nifi-1.21.0-bin.zip
sudo rm -rf nifi-1.21.0-bin.zip

# go to conf/nifi.properties to change nifi.web.https.host to ec2 ip dns address
# Set your new port number here
new_host="ec2-3-84-235-234.compute-1.amazonaws.com"

# Use sed to update the nifi.properties file
sed -i "s/^nifi.web.https.host=.*/nifi.web.https.host=${new_host}/" ./nifi-1.21.0/conf/nifi.properties

# start nifi
sudo ./nifi-1.21.0/bin/nifi.sh start