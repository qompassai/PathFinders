# Starting Ollama as a User-Level Service on WSL2 Arch Linux

To start **Ollama** as a user-level service on **WSL2 Arch Linux**, you need to create a systemd service for it. However, WSL2 by default doesn't include systemd, so you'll need to either enable systemd or create a custom script that runs automatically when you start your WSL2 instance. Below, I provide both approaches.

## Approach 1: Using `systemd` to Start Ollama as a User-Level Service
To use systemd to manage a user-level service, follow these steps:

### Step 1: Enable Systemd on WSL2
By default, WSL2 does not use `systemd`. To enable `systemd`, you can modify your WSL2 environment to allow systemd to run:

1. **Edit `/etc/wsl.conf`** to include:
   ```ini
   [boot]
   systemd=true
   ```
2. Restart your WSL2 instance.

### Step 2: Create a Systemd User Service for Ollama
1. **Create a Service File**:
   Create a new service file for Ollama. This file will instruct `systemd` how to manage the Ollama process.
   
   ```bash
   mkdir -p ~/.config/systemd/user
   nano ~/.config/systemd/user/ollama.service
   ```
   
   **Add the following to `ollama.service`**:
   ```ini
   [Unit]
   Description=Ollama Service
   After=network.target

   [Service]
   ExecStart=/usr/local/bin/ollama start
   Restart=always
   RestartSec=10
   User=%u

   [Install]
   WantedBy=default.target
   ```
   Make sure to replace `/usr/local/bin/ollama` with the correct path if Ollama is installed somewhere else.

2. **Reload Systemd and Enable the Service**:
   Reload systemd to recognize the new service and then enable it.

   ```bash
   systemctl --user daemon-reload
   systemctl --user enable ollama.service
   systemctl --user start ollama.service
   ```

3. **Verify the Service Status**:
   ```bash
   systemctl --user status ollama.service
   ```

## Approach 2: Using a `.bashrc` Script for Startup
If you prefer not to enable systemd in WSL2, you can add commands to start Ollama automatically in your `.bashrc` or `.profile` file:

1. **Edit `.bashrc`** or **`.profile`**:
   ```bash
   nano ~/.bashrc
   ```

2. **Add a Command to Start Ollama**:
   Add the following lines to the end of your `.bashrc`:

   ```bash
   if pgrep -x "ollama" > /dev/null
   then
       echo "Ollama is already running."
   else
       nohup /usr/local/bin/ollama start &>/dev/null &
       echo "Starting Ollama..."
   fi
   ```
   - This script will check if Ollama is already running (`pgrep -x "ollama"`), and if not, it will start it.
   - Make sure `/usr/local/bin/ollama` is the correct path to the Ollama binary.

3. **Reload `.bashrc`**:
   Run:
   ```bash
   source ~/.bashrc
   ```

## Summary
- **Systemd Approach**: 
  - Enable systemd in WSL2, then create a `~/.config/systemd/user/ollama.service` file and use `systemctl` to manage it.
- **Script in `.bashrc` Approach**:
  - Add a script to `.bashrc` or `.profile` to run Ollama automatically on shell start.

The **systemd approach** is more robust since it provides better service management, such as restarting Ollama if it crashes. However, if you prefer a simpler setup, the `.bashrc` approach is also effective.
