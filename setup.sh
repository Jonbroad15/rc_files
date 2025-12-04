#!/bin/bash

set -e  # Exit on error

# Colors for output
GREEN="\033[0;32m"
NC="\033[0m"

# Determine if sudo is available
if command -v sudo &> /dev/null; then
  SUDO="sudo"
else
  SUDO=""
fi

# prompt to print out home directory, everything will be installed relative to home, do you want to change it (leave blank to keep current)
read -p "Current home directory is $HOME. Do you want to change it? (leave blank to keep current): " NEW_HOME
if [ -n "$NEW_HOME" ]; then
    echo 'export HOME="'"$NEW_HOME"'"' >> ~/.bashrc
    echo 'source '"$NEW_HOME"'/.bashrc' >> ~/.bash_profile
    export HOME="$NEW_HOME"
    echo -e "${GREEN}Home directory changed to $HOME${NC}"
fi
mkdir -p $HOME/bin
mkdir -p $HOME/opt
export PATH="$HOME/bin:$PATH"

# install nvm if not installed
# Check if nvm is installed
if [ -d "$HOME/.nvm" ]; then
    echo -e "${GREEN}nvm is already installed. Skipping installation.${NC}"
else
    echo -e "${GREEN}Installing nvm...${NC}"
    # Install nvm
    # Download and run the nvm install script
    # Using the official nvm install script from GitHub
    # This installs the latest version of nvm
    export NVM_DIR="$HOME/.nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
    # Load nvm into the current shell session
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi  

# Install Node.js LTS using nvm
echo -e "${GREEN}Installing Node.js LTS version using nvm...${NC}"
nvm install --lts
nvm use --lts


# Install Neovim (latest from binary) if not already installed
if ! command -v nvim &> /dev/null; then
  echo -e "${GREEN}Installing Neovim from binary...${NC}"
  NVIM_TAR=nvim-linux-x86_64.tar.gz
  curl -LO https://github.com/neovim/neovim/releases/download/v0.11.1/$NVIM_TAR
  tar xzvf $NVIM_TAR
  $SUDO mv nvim-linux-x86_64 $HOME/opt/nvim
  $SUDO ln -sf $HOME/opt/nvim/bin/nvim $HOME/bin/nvim
  rm $NVIM_TAR
else
  echo -e "${GREEN}Neovim is already installed. Skipping installation.${NC}"
fi

# Prompt before copying .bashrc
echo -e "${GREEN}Do you want to copy .bashrc from the repository to your home directory? (y/n)${NC}"
read -r copy_bashrc
if [[ "$copy_bashrc" == "y" || "$copy_bashrc" == "Y" ]]; then
  echo -e "${GREEN}Copying .bashrc...${NC}"
  cp .bashrc $HOME/.bashrc
else
  echo -e "${GREEN}Skipping .bashrc copy.${NC}"
fi

echo 'export HOME="$HOME"' >> $HOME/.bashrc
echo 'export PATH="$HOME/bin:$PATH"' >> $HOME/.bashrc

# Install Miniconda (latest Linux x86_64)
if compgen -G "$HOME/*conda*" > /dev/null; then
  echo -e "${GREEN}Miniconda already installed at $HOME/miniconda. Skipping installation.${NC}"
else
  echo -e "${GREEN}Installing Miniconda...${NC}"
  MINICONDA_INSTALLER=Miniconda3-latest-Linux-x86_64.sh
  curl -LO https://repo.anaconda.com/miniconda/$MINICONDA_INSTALLER
  bash $MINICONDA_INSTALLER -b -p $HOME/miniconda
  rm $MINICONDA_INSTALLER
fi

# Initialize Conda
eval "$($HOME/miniconda/bin/conda shell.bash hook)"
conda init

# Copy nvim config
echo -e "${GREEN}Setting up Neovim config...${NC}"
mkdir -p $HOME/.config
cp -r nvim $HOME/.config/


# install tmux if not installed
if ! command -v tmux &> /dev/null; then
    echo -e "${GREEN}Installing tmux...${NC}"
    bash install_tmux.sh
else
    echo -e "${GREEN}tmux is already installed. Skipping installation.${NC}"
fi

# Copy tmux config
# Prompt before copying .tmux.conf
echo -e "${GREEN}Do you want to copy .tmux.conf from the repository to your home directory? (y/n)${NC}"
read -r copy_tmux
if [[ "$copy_tmux" == "y" || "$copy_tmux" == "Y" ]]; then
  echo -e "${GREEN}Copying .tmux.conf...${NC}"
  cp .tmux.conf $HOME/.tmux.conf
else
  echo -e "${GREEN}Skipping .tmux.conf copy.${NC}"
fi  

# Copy ta to bin
echo -e "${GREEN}Setting up 'ta' script...${NC}"
cp ta $HOME/bin/ta
echo -e "${GREEN}'ta' script setup complete!${NC}"

# check if aws cli is installed, if not install it
# Check if aws cli is installed
if ! command -v aws &> /dev/null; then
    echo -e "${GREEN}Installing AWS CLI...${NC}"
    bash install_aws_cli.sh
else
    echo -e "${GREEN}AWS CLI is already installed. Skipping installation.${NC}"
fi

echo -e "${GREEN}Environment setup complete! Restart your terminal to apply changes.${NC}"
