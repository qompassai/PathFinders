# Setting up Firewalls for secure remote connections

## We are going to set up the uncomplicated firewall (UFW) to set up secure remote connections that will be authenticated with our public GPG keys we have created. 

```MacOS"
brew update && brew upgrade && brew cleanup && brew doctor
brew install ufw pinentry-mac gnupg
```

```Arch/WSL2 Arch
sudo pacman -Syyu && sudo pacman -Scc && sudo pacman -S ufw pinentry-ncurses gnupg
```

```Ubuntu/Debian | WSL2 Ubuntu/Debian
sudo apt update && sudo apt upgrade 
sudo apt install ufw
```

## Enable UFW

```MacOS | Arch/WSL2 Arch | Ubuntu/Debian | WSL2 Ubuntu/Debian
sudo ufw enable
sudo ufw allow 22/tcp
sudo ufw allow 2343/tcp
sudo ufw reload
```

- Configure ssh daemon (sshd) for public key authentication over ssh to remote servers

```MacOS | Arch/WSL2 Arch | Ubuntu/Debian | WSL2 Ubuntu/Debian
sudo nvim /etc/ssh/sshd_config
```

- Uncomment the following lines then :wq to save

```MacOS | Arch/WSL2 Arch | Ubuntu/Debian | WSL2 Ubuntu/Debian
PubkeyAuthentication yes
PasswordAuthentication no
```

- Restart the ssh daemon

```MacOS
sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist
```

```Arch/WSL2 Arch | Ubuntu/Debian | WSL2 Ubuntu/Debian
systemctl enable ssh
systemctl daemon-reload
systemctl restart sshd
systemctl restart ssh
```

- Confirm the changes

```MacOS | Arch/WSL2 Arch | Ubuntu/Debian | WSL2 Ubuntu/Debian
grep -E "PubkeyAuthentication|PasswordAuthentication" /etc/ssh/sshd_config
```

## Setting up the gpg-agent to manage our remote connections

- make a new directory for ssh and gpg and copy gpg.conf, dirmngr.conf and gpg-agent.conf files to them

```MacOS | Arch/WSL2 Arch | Ubuntu/Debian | WSL2 Ubuntu/Debian
mkdir -p .ssh
mkdir -p .gnupg
chmod 700 ~/.ssh
chown -R $USER:$USER ~/.ssh
chown -R $USER:$USER ~/.gnupg
z .gnupg
touch gpg.conf
touch gpg-agent.conf
touch sshcontrol
touch dirmngr.conf
```

- Confirm permissions

```MacOS | Arch/WSL2 Arch | Ubuntu/Debian | WSL2 Ubuntu/Debian
ls -ld .ssh
ls -ld .gnupg
```

- Add gpg-agent config to your shell config (.zshrc/.bashrc

```MacOS
z ~
nvim .zshrc
```

### Copy the below then press esc, :wq and source .zshrc

```MacOS
#QPG
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
```

### Arch/Ubuntu/WSL2 Copy the below then press esc, :wq and source .bashrc

```Arch/WSL2 Arch | WSL2 | Linux
#QPG
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
```

- Reload the gpg-agent

```Arch/WSL2 Arch | WSL2 | Linux
gpg-connect-agent reloadagent /bye
```

- Find your gpg subkey

```Arch/WSL2 Arch | WSL2 | Linux
gpg --list-keys --with-subkey-fingerprints "email for your keys"
```

- export your gpg key

```Arch/WSL2 Arch | WSL2 | Linux
gpg --armor --export --export-options export-minimal --export-ssh-key <KEY_ID> > my_public_key.asc
```

## Level 5 Finish line

- Great job!
