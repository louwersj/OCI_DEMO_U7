#!/bin/bash
sudo cd /tmp

# Get the fedora EPEL repo and install it. This is required to 
# able to install ansible on the node. 
sudo curl http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm --output /tmp/epel.rpm --silent
sudo rpm -Uvh /tmp/epel.rpm

# Install ansible for node configuration. We will be using ansible 
# for all the configuration options. 
sudo yum -y install ansible

# get the default ansible playbook. The default ansible playbook
# for each node is named "node_configuration.yaml
sudo curl https://raw.githubusercontent.com/louwersj/OCI_DEMO_U7/master/ENV/VM0/node_configuration.yaml --output /tmp/node_configuration.yaml --silent

# Run the default ansible playbook.
sudo ansible-playbook /tmp/node_configuration.yaml
