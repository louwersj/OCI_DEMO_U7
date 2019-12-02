#!/bin/bash

# Ensure this variable points to the GIT location where we store the config for this specific node. 
CONF_GIT_BASE="https://raw.githubusercontent.com/louwersj/OCI_DEMO_U7/master/ENV/VM0/"

# Ensure we are fully fully certain that we run in /tmp even though we explicitly state /tmp in the 
# used commands we do not want to take any change that we dirty our newly created VM
sudo cd /tmp

# Get the fedora EPEL repo and install it. This is required to able to install ansible on the node. 
logger "boot.sh - Download EPEL RPM"
sudo curl http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm --output /tmp/epel.rpm --silent
sudo rpm -Uvh /tmp/epel.rpm

# Install ansible for node configuration. We will be using ansible for all the configuration options. 
logger "boot.sh - Install ansible"
sudo yum -y install ansible

# get the default ansible playbook. The default ansible playbook for each node is named 
# "node_configuration.yaml and use CONF_GIT_BASE to form the full URI.
logger "boot.sh - Download node_configuration from $CONF_GIT_BASE/node_configuration.yaml"
sudo curl "$CONF_GIT_BASE/node_configuration.yaml" --output /tmp/node_configuration.yaml

# Run the default ansible playbook.
logger "boot.sh - Run ansible playbook /tmp/node_confirguration.yaml"
sudo ansible-playbook /tmp/node_configuration.yaml
