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

# Install Node.js (LTS) if not installed
if ! command -v node &> /dev/null; then
  echo -e "${GREEN}Installing Node.js...${NC}"
  curl -fsSL https://deb.nodesource.com/setup_lts.x | $SUDO bash -
  $SUDO apt-get install -y nodejs
else
  echo -e "${GREEN}Node.js is already installed. Skipping installation.${NC}"
fi

# Install Neovim (latest from binary) if not already installed
if ! command -v nvim &> /dev/null; then
  echo -e "${GREEN}Installing Neovim from binary...${NC}"
  NVIM_TAR=nvim-linux-x86_64.tar.gz
  curl -LO https://github.com/neovim/neovim/releases/download/v0.11.1/$NVIM_TAR
  tar xzvf $NVIM_TAR
  $SUDO mv nvim-linux-x86_64 /opt/nvim
  $SUDO ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
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

echo -e "${GREEN}Environment setup complete! Restart your terminal to apply changes.${NC}"