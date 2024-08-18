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
- If Python is not installed, visit python.org and download version 3.12 https://www.python.org/ftp/python/3.12.0/python-3.12.0-macos11.pkg
- Run the installer and follow the prompts to install Python.
## Step 3: Install the Hugging Face Hub Library
- In the Terminal, type the following command and press Enter:
```bash
pip install huggingface_hub
```
- Wait for the installation to complete.
## Step 4: Link Your Account to Hugging Face Hub
- In the Terminal, type the following command and press Enter:
```bash
huggingface-cli login
```
- You'll be prompted to enter your Hugging Face access token.
- To get your access token:
- Go back to the Hugging Face website and log in.
- Click on your profile picture in the top right corner.
- Select "Settings" from the dropdown menu.
- In the left sidebar, click on "Access Tokens".
- Click "New token", give it a name, and select the desired permissions.
- Click "Generate a token" and copy the token that appears.
- Paste the token into the Terminal when prompted (note: you won't see the token as you paste it, this is normal for security reasons).
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

