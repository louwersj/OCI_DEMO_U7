#!/bin/bash
# NAME:
#   boot.sh
#
# DESC:
#   Standard boot.sh script to be automatically started on first boot
#   of a new VM. This will ensure that the assoicated ansible playbook
#   will be downloaded and executed. The basic of this script is 
#   static with the exception of the CONF_GIT_BASE variable which is 
#   per node (VM) different and points to the exact git location to 
#   enable the script to aquire the correct playbook. 
#
# LICENSE:
# Copyright (C) 2015  Johan Louwers
#
# This code is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This code is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this code; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  
# 02110-1301, USA.
# *
# */

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
