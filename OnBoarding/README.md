# Setup Guide for Mac Users

## Table of Contents
1. [Create a Hugging Face Account](#step-1-create-a-hugging-face-account)
2. [Install Python](#step-2-install-python-if-not-already-installed)
3. [Install the Hugging Face Hub Library](#step-3-install-the-hugging-face-hub-library)
4. [Link Your Account to Hugging Face Hub](#step-4-link-your-account-to-hugging-face-hub)
5. [Verify Your Hugging Face Connection](#step-5-verify-your-hugging-face-connection)
6. [Install GitHub CLI](#step-6-install-github-cli)
7. [Set Up SSH for GitHub](#step-7-set-up-ssh-for-github)
8. [Configure GitHub CLI](#step-8-configure-github-cli)
9. [Using GitHub CLI](#step-9-using-github-cli)
10. [Using Hugging Face CLI](#step-10-using-hugging-face-cli)

## Step 1: Create a Hugging Face Account
- Open your web browser (like Safari or Chrome) on your MacBook.
- Go to the Hugging Face website by typing "huggingface.co" in the address bar.
- Click on the "Sign Up" button in the top right corner of the page.
- Enter your email address and choose a password.
= Click "Next" and complete your profile by entering a username and your full name.
- Agree to the terms of service and click "Create Account".
- Check your email inbox for a verification email from Hugging Face and click the link to confirm your account.
## Step 2: Install Python (if not already installed)
- Open the Terminal app on your MacBook (you can find it in Applications > Utilities).
- Type "python --version" and press Enter to check if Python is installed.
- If Python is not installed, visit python.org and download version 3.12 https://www.python.org/ftp/python/3.12.0/python-3.12.0-macos11.pkg (or latest python 3.12 version available)
- Run the installer and follow the prompts to install Python.
## Step 3: Install the Hugging Face Hub Library
- In the Terminal, type the following command and press Enter:
```bash
pip install 'huggingface_hub[hf_transfer,cli,tensorflow,torch,fastai]' -U

```
- Wait for the installation to complete.
- add the following variable to path to enable better transfer of large files from huggingface
```bash
export HF_HUB_ENABLE_HF_TRANSFER=1
```
## Step 4: Link Your Account to Hugging Face Hub
- In the Terminal, type the following command and press Enter:
```bash
huggingface-cli login
```
- You'll be prompted to enter your Hugging Face access token.
## Getting your access token:
- Go back to the Hugging Face website and log in.
- Click on your profile picture in the top right corner.
- Select "Settings" from the dropdown menu.
- In the left sidebar, click on "Access Tokens".
- Click "New token", give it a name, and select the desired permissions.
- Click "Generate a token" and copy the token that appears.
- Select a Token Type of Fine-grained, Read, or Write. For basic use-cases **select Write**, for advanced/enterprise use, **select Fine-Grained**
- Paste the token into the Terminal when prompted (note: you won't see the token as you paste it, **this is normal** for security reasons).
- Press Enter.
## Step 5: Verify Your Connection
- In the Terminal, type the following command and press Enter:
```bash
huggingface-cli whoami
```
- If you see your Hugging Face username, congratulations! You've successfully linked your account to the Hugging Face Hub.
- That's it! You've now created a Hugging Face account and linked it to the Hugging Face Hub on your MacBook. You're ready to start exploring and using the resources available on the Hub.
- Remember, if you encounter any issues or need more help, Hugging Face has excellent documentation and a supportive community you can turn to for assistance.

### https://www.youtube.com/watch?v=Rm8g33O-ClE 

## Step 6: Install Github CLI
- Install homebrew if it isn't already installed
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
- Install Github Command Line Interface (CLI)
```bash
brew install gh
```

## Step 7: Set up Secure Shell (SSH) for Github
**SSH comes pre-installed on macOS, so you don't typically need to install it separately.**
- Generate an SSH key replacing "your_email@example.com" with your email address inside ""
## Understanding the SSH Key Generation Command

```text
The command `ssh-keygen -t ed25519 -C "your_email@example.com"` is used to generate a new SSH key pair. 
1. `ssh-keygen`: This is the program used to create SSH key pairs.

2. `-t ed25519`: This option specifies the type of key to create.
   - `ed25519` is an elliptical curve cryptography offering 128-bits of security designed for use with the public key encryption protocols like Elliptic-Curve Diffie-Helman (ECDH) key agreement exchange. 
   - It's generally preferred over older types like RSA for its strong security and small key size.

3. `-C "your_email@example.com"`: This adds a comment to the key.
   - The `-C` flag stands for "comment".
   - Typically, an email address is used as the comment to help identify the key.
   - This comment is purely for your reference and doesn't affect the key's functionality.

When you run this command:
1. You'll be prompted to choose a location to save the key (default is usually fine).
2. You'll be asked to enter a passphrase (highly recommended for security).
3. The command generates two files:
   - A private key (usually saved as `~/.ssh/id_ed25519`)
   - A public key (usually saved as `~/.ssh/id_ed25519.pub`)

**The private key should be kept SECRET and SECURE on your local machine, while the public key can be shared and added to services like GitHub for authentication.**

This command creates a highly secure SSH key pair that you can use for various authentication purposes, including GitHub access and secure server logins.

```bash
 ssh-keygen -t ed25519 -C "your_email@example.com"
```
- You'll know it's right because it will look like this
```bash
[OnBoarding]$ ssh-keygen -t ed25519 -C "map@qompass.ai"
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/phaedrus/.ssh/id_ed25519):
```
- Start the SSH agent (what handles your keys):
```bash
eval "$(ssh-agent -s)"
```
- Add your SSH key to the agent
```bash
ssh-add ~/.ssh/id_ed25519
```
- Add ssh agent to your shell config (~/.zshrc for zshh or ~/.bashrc for bash). You can use nano, vim, or nvim to access. 
**Depending on your config, you may need to use sudo (super user do)to edit and save**
- Access your shell config
```bash
vim ~/.zshrc
```
- Add the following to your shell config
```bash
# Start SSH agent
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
  ssh-add -A 2>/dev/null
fi
```
**This script checks if the SSH agent is already running. If not, it starts the agent and adds your SSH keys.**
- Save and source your shell config to activate the script. 
```bash
# For neovim/vim (in normal mode - ie press esc if in insert mode)
:wq
# For nano
Ctrl or or Cmd or ^ +O to save (depending on key bindings)
Ctrl or Cmd ^ +X to exit. Press Y to save changes when prompted, n to discard, and Ctrl+C to cancel an action/oopsie.
# Source (turn on) your new shell config
# for zsh
source ~/.zshrc
# for bash
source ~/.bashrc
```
**If you opened your shell config without sudo, it may prevent you from using :wq. If this is the case, type u (undo) until it is at the oldest change, then use :qa to quit.**
- To make shell editable (use with sudo in front if it denies permission)
```bash
chmod u+w ~/.zshrc
chmod 644 ~/.zshrc

# If for some reason you don't own the file (ie you have to use sudo to make changes to your shell config)
# For zsh
sudo chown $USER:$USER ~/.zshrc
# For bash
sudo chown $USER:$USER ~/.bashrc

```
* chmod: The command to change file permissions
* u: Refers to the user (owner) of the file
* +w: Adds write permission
* ~/.zshrc: The path to your .zshrc file

 ## Add SSH Key to GitHub using GitHub CLI

- Copy the SSH key to your clipboard:
```bash
pbcopy < ~/.ssh/id_ed25519.pub
```
- Authenticate with github cli (gh), following the prompts to select ssh as default 
```bash
gh auth login
```
- Add keys to your github
gh ssh-key add ~/.ssh/id_ed25519.pub -t "Something unique"
**Replace "Something unique" with a descriptive title for your key.**
- Check that your key has been added
```bash
gh ssh-key list
```


