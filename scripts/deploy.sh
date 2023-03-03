#!/bin/bash

update() {
    sudo apt update -y
    sudo apt upgrade -y

    return 0
}
update

install_ruby() {
    sudo apt install ruby-full wget -y
    
    return 0
}
install_ruby

check_ruby() {
    which ruby
    if [ $? -eq 0 ]
    then
    cd /home/ubuntu
    wget https://aws-codedeploy-eu-west-2.s3.eu-west-2.amazonaws.com/latest/install
    chmod +x ./install
    sudo ./install auto
    sudo service codedeploy-agent start
    sudo mkdir /home/ubuntu/dev
    echo "done"

    return 0

    else
        update
        install_ruby
        check_ruby
    fi
}
check_ruby
