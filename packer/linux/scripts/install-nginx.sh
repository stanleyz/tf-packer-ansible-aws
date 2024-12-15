#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Determine the Linux distribution
if command_exists lsb_release; then
    DISTRO=$(lsb_release -si)
elif command_exists uname; then
    DISTRO=$(uname -s)
else
    echo "Unable to determine the Linux distribution"
    exit 1
fi

# Install Ansible based on the distribution
case $DISTRO in
    Ubuntu|Debian)
        echo "Detected Debian/Ubuntu system. Installing Ansible..."
        
        # Update package list
        sudo apt update
        
        # Install Ansible
        sudo apt install -y ansible
        ;;
    
    CentOS|RedHat|Fedora)
        echo "Detected CentOS/RHEL/Fedora system. Installing Ansible..."
        
        # Enable EPEL repository for CentOS/RHEL
        sudo yum install -y epel-release

        # Install Ansible
        sudo yum install -y ansible
        ;;
    
    *)
        echo "Unsupported Linux distribution: $DISTRO"
        exit 1
        ;;
esac

# Verify the installation
if command_exists ansible; then
    echo "Ansible installation was successful!"
    ansible --version
else
    echo "Ansible installation failed."
    exit 1
fi