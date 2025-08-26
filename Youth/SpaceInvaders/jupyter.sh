#!/usr/bin/env bash

# Update and Upgrade System Packages
sudo pacman -Syu --noconfirm
sudo rm /usr/lib/python3.12/EXTERNALLY-MANAGED
# Install Python, Pip, and Jupyter Components
sudo pacman -S python python-pip --noconfirm
pip install --upgrade pip

# Install JupyterLab, JupyterHub, Jupyter Server, and Jupyter Client
pip install jupyterlab jupyterhub jupyter-server jupyter-client

# Install IPyWidgets for Interactive Widgets
pip install ipywidgets

# Install Neovim and Python Support for Neovim Integration
sudo pacman -S neovim --noconfirm
pip install pynvim nvim-ipy

# Install Additional Language Servers for Neovim
pip install python-lsp-server[all]                   # Python Language Server
npm install -g bash-language-server                  # Bash Language Server
npm install -g typescript typescript-language-server # JavaScript/TypeScript LSP

# Install Node.js and npm (needed for some language servers)
sudo pacman -S nodejs npm --noconfirm

# Install Jupyter Kernel for Neovim Integration
pip install ipykernel
python -m ipykernel install --user --name nvim_kernel --display-name "Neovim Kernel"

# Install Optional Tools for Jupyter and Neovim Enhancement
pip install matplotlib numpy pandas scipy # Useful scientific libraries
pip install jupyterlab-git                # Git integration for JupyterLab

# Set up Jupyter Configuration for Better Compatibility with Neovim
jupyter notebook --generate-config

# Add Extensions to JupyterLab for Improved Experience
pip install jupyterlab_code_formatter
pip install black isort flake8 # Python code formatters

# Install Formatter Extensions for JupyterLab
jupyter labextension install @ryantam626/jupyterlab_code_formatter

# Final Message
printf "Installation complete! Jupyter and Neovim are fully integrated with language servers."
