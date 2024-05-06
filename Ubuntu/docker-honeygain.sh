#!/bin/bash

clear

echo "Docker Install Latest - Linux Easy Install Scripts"
echo "https://github.com/auroraskylabs/Quick-Installers-For-Linux"
echo

# Ask for user agreement to Honeygain Terms of Service
read -p "Do you agree to the Honeygain Terms of Service? (yes/no): " agreement
if [[ $agreement != [Yy] ]]; then
    echo "Honeygain installation cancelled."
    read -p "Would you like the installation for docker to continue? (yes/no): " continue_install
    if [[ $continue_install != [Yy] ]]; then
        echo "Aborting Docker installation."
        exit 1
    fi
fi

# If user agrees to Honeygain Terms of Service, ask for credentials
if [[ $agreement == [Yy] ]]; then
    read -p "Honeygain Email: " email
    read -sp "Password: " password
    echo
    read -p "Device Name: " devicename
fi

echo "You are about to install Docker Engine and its components/prerequisites."

if command -v docker &> /dev/null; then
    # Docker is installed
    echo -e "\e[31mDOCKER INSTALLATION DETECTED!"
    read -p "The current Docker installation will be removed and data will be lost. Would you like to proceed anyway? (y/n): " answer
    if [[ $answer == [Yy] ]]; then
        echo "Proceeding with Docker installation..."
    else
        echo "Aborting Docker installation."
        exit 1
    fi
else
    # Docker is not installed
    read -p "Docker is not installed. Do you want to proceed with the installation? (y/n): " answer
    if [[ $answer != [Yy] ]]; then
        echo "Aborting Docker installation."
        exit 1
    fi
fi

# Install dependencies
apt update
apt install -y sudo git net-tools make gnupg2 whois traceroute

# Remove existing Docker packages
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove -y $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Run Honeygain container if agreed to Terms of Service
if [[ $agreement == [Yy] ]]; then
    docker run -d --restart always honeygain/honeygain -tou-accept -email $email -pass $password -device $devicename
fi



