#!/bin/bash
# After the VM has been provisioned using create.sh -- run this crazy shell as a oneliner after you login to the VM

# > curl https://raw.githubusercontent.com/dashaun/azure-jumpbox/master/postDeploy.sh | sudo bash

apt update -y
apt upgrade -y
apt install -y build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt1-dev libxml2-dev libssl-dev libreadline7 libreadline-dev libyaml-dev libsqlite3-dev sqlite3 direnv
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
