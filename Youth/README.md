# Setting Up Nerd Fonts in WSL2 Arch Linux for Neovim

To use the "DaddyTimeMono" Nerd Font from the GitHub repository in WSL2 Arch Linux for Neovim, you need to perform the following steps. These steps will guide you through cloning the repository, copying the necessary fonts, installing them locally, and configuring your terminal to use them.

## Step 1: Clone the Nerd Fonts Repository

First, you'll want to clone the `nerd-fonts` repository or just the specific folder for "DaddyTimeMono":

```bash
# Go to a directory where you want to clone the fonts
cd ~/Downloads

# Clone the specific directory for DaddyTimeMono
git clone --depth 1 --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
git sparse-checkout set patched-fonts/DaddyTimeMono
```

This will clone only the necessary part of the repository to save time and storage space.

## Step 2: Install the Font in Your Local System

Now that you have the fonts, you need to install them in your WSL2 Arch Linux environment so Neovim can access them:

1. **Copy the Fonts to the Local Fonts Directory**:
   The `patched-fonts/DaddyTimeMono` directory should now contain the `.ttf` font files you need.

   ```bash
   mkdir -p ~/.local/share/fonts
   cp patched-fonts/DaddyTimeMono/*.ttf ~/.local/share/fonts/
   ```

2. **Update the Font Cache**:
   Run `fc-cache` to update the font cache so that your system can recognize the newly installed fonts.

   ```bash
   fc-cache -fv
   ```

3. **Verify Installation**:
   Confirm that the font has been successfully installed:

   ```bash
   fc-list | grep -i "DaddyTime"
   ```

   This command should display the paths to the installed DaddyTimeMono Nerd Fonts.

## Step 3: Configure Windows Terminal to Use DaddyTimeMono Nerd Font

Since you are using WSL2 on a Windows machine, you need to configure **Windows Terminal** to use the "DaddyTimeMono Nerd Font":

1. **Open Windows Terminal Settings**:
   - Click on the down arrow in the title bar and select "Settings".

2. **Select the Profile for WSL**:
   - Choose the profile that you are using for Arch Linux (likely named "Arch Linux").

3. **Set the Font**:
   - Find the `"fontFace"` property and set it to `"DaddyTimeMono Nerd Font"`.

   Example JSON Configuration:
   ```json
   "profiles": {
       "list": [
           {
               "guid": "{your-profile-guid}",
               "name": "Arch Linux",
               "fontFace": "DaddyTimeMono Nerd Font",
               "fontSize": 12
           }
       ]
   }
   ```
   
   **Note**: To find the `guid`, simply go to the settings in Windows Terminal, find the profile you're using (like "Arch Linux"), and copy the `guid` value from there. It will look like a long string of letters and numbers inside curly braces.

4. **Save and Restart**:
   - Save the settings and restart the Windows Terminal.

## Step 4: Verify Font Availability in Neovim

Now that your terminal is set to use the "DaddyTimeMono Nerd Font", Neovim should inherit this font. To verify that everything is working as expected:

1. **Open Neovim in WSL2**:

   ```bash
   nvim testfile
   ```

2. **Test Font Rendering**:
   Try pasting in some known Nerd Font symbols to check if they render correctly:

   ```
       
   ```

3. **Neovim Plugin Check**:
   If you’re using a plugin that utilizes icons (such as `nvim-tree`, `lualine`, or `bufferline`), ensure that the icons are being displayed properly. If you see placeholder boxes instead of icons, the font isn’t being applied correctly.

## Step 5: Additional Debugging (if Font Not Detected)

If the Nerd Font still doesn’t work, consider the following troubleshooting steps:

1. **Check Terminal Font Configuration**:
   Make sure you have entered the correct font name exactly as listed by Windows. Sometimes the name might be slightly different, so verify it via the Windows Fonts settings (`Control Panel > Fonts`).

2. **Permissions Issue**:
   Ensure that your WSL2 user has the proper permissions to access the font files in `~/.local/share/fonts`.

## Summary

1. **Clone the Nerd Fonts repository** and extract only the "DaddyTimeMono" folder.
2. **Install the font** locally in `~/.local/share/fonts` and update the cache with `fc-cache -fv`.
3. **Configure your terminal** (Windows Terminal) to use the "DaddyTimeMono Nerd Font".
4. **Verify** the setup in Neovim and troubleshoot if necessary.

After following these steps, Neovim should pick up the "Mono Daddy Time Nerd Font" in your WSL2 Arch Linux setup and properly render the glyphs and icons.

