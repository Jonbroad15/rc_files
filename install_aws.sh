#!/bin/bash

# mkdir $HOME/opt
# mkdir $HOME/bin
mkdir -p ~/opt
mkdir -p ~/bin
echo "Installing AWS CLI v2 to ~/opt/aws-cli and creating symlink in ~/bin..."

# Download the installer
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the installer
unzip -o awscliv2.zip

# Install to ~/aws-cli and create a symlink in ~/bin
# -i specifies the install directory
# -b specifies where to put the 'aws' executable symlink
./aws/install -i ~/opt/aws-cli -b ~/bin

# Add ~/bin to PATH if it's not already there (for the current session)
export PATH=$PATH:~/bin

# Verify installation
echo "Verifying installation..."
which aws
aws --version
