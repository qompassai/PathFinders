# Configuring Gnu Privacy Guard (GPG) with Github
- Confirm your installation of github cli
```bash
gh auth login
```
- Test the key  
```bash
ssh -T git@github.com
```
- Remember to ensure your SSH agent is running and the key is loaded. If its's not in your shell config run these commands one line at a time.
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```
**If successful, you'll see a message confirming that you've authenticated, but GitHub does not provide shell access.**

## Setting up GNU Privacy Guard (GPG) for Github

1. Install GPG
```bash
brew install gnupg
```
2. Generate a new GPG key
```bash
gpg --expert --full-generate-key
```
- You'll see an output like the one below
```bash
gpg --expert --full-generate-key
Please select what kind of key you want:
   (1) RSA and RSA
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
   (7) DSA (set your own capabilities)
   (8) RSA (set your own capabilities)
   (9) ECC (sign and encrypt) *default*
  (10) ECC (sign only)
  (11) ECC (set your own capabilities)
  (13) Existing key
  (14) Existing key from card
Your selection?
```
**Press 9 to choose "ECC (sign and encrypt)" or "ECC and ECC",**
- Then press 1 to select Curve 25519 *default*, based on the output below
```bash
Please select which elliptic curve you want:
   (1) Curve 25519 *default*
   (2) Curve 448
   (3) NIST P-256
   (4) NIST P-384
   (5) NIST P-521
   (6) Brainpool P-256
   (7) Brainpool P-384
   (8) Brainpool P-512
   (9) secp256k1
```
- Type 1y for one year expiration
```bash
Key is valid for? (0) 1y
Key expires at Mon 25 Aug 2025 06:28:38 PM PDT
Is this correct? (y/N)
```
- Then type in your name, email address, and a comment to be identified with your public key
```bash
GnuPG needs to construct a user ID to identify your key.

Real name: Matt P
Email address: map@qompass.ai
Comment: example
```
The final output will looke like the below. Type o and then enter a passphrase for the new keypair. 
```bash
Real name: Matt P
Email address: map@qompass.ai
Comment: example
You selected this USER-ID:
    "Matt P (example) <map@qompass.ai>"
```

- Check if you made the key correctly by listing your secret key's
```bash
gpg --list-secret-keys --keyid-format LONG
```
**Your key ID is on the line starting with "sec" after the "/"**
- Export your GPG public key from your secret key id.
```bash
gpg --armor --export YOUR_KEY_ID > gpg_github_key.txt
```
**You can name the public key anything.txt, just make sure it is unique to you**
- Add the GPG key to your GitHub account using the GitHub CLI:

```bash
gh gpg-key add gpg_github_key.txt
```
- Configure Git to use your GPG key:
```bash
git config --global user.signingkey YOUR_KEY_ID
git config --global commit.gpgsign true
```
- Add GPG to your ~/.bash_profile or ~/.zshrc by pasting export GPG_TTY=$(tty) to your shell config:
```bash
vim ~/.zshrc
# Paste the line exactly as it is below into your shell config
export GPG_TTY=$(tty)
```
- source the shell to have it take effects
```bash
source ~/.zshrc
```
- Verify GPG key is added to Github
```bash
gh gpg-key list
```
## Show your new security skills on Github
- Create a new repository with AGPL 3.0 license using GitHub CLI:
```bash
gh repo create "cool project name" --public --license agpl-3.0 --clone
```
**Please come up with a project name unique to you**
- Change into the new directory
```bash
cd my-secure-project
```
- Create a README.md file and add the text below
```bash
vim README.md
# My Secure Project

This project is licensed under the GNU Affero General Public License v3.0 (AGPL-3.0).

## Using GPG Keys with GitHub CLI for Enhanced Security and Privacy

This project utilizes GPG (GNU Privacy Guard) keys for authentication with GitHub through the GitHub CLI. Here's why this approach is valuable:

### Security Benefits:
1. **Identity Verification**: GPG keys provide cryptographic proof of your identity, ensuring that commits and operations are genuinely from you.
2. **Tampering Prevention**: Signed commits cannot be altered without detection, maintaining the integrity of your codebase.
3. **Access Control**: GPG keys can be easily revoked if compromised, providing better control over repository access.

### Privacy Advantages:
1. **Email Protection**: Your email address can be kept private while still verifying your identity.
2. **Pseudonymous Contributions**: You can contribute under a pseudonym while still cryptographically verifying your identity.

### Workflow Improvements:
1. **CLI Integration**: GitHub CLI with GPG key authentication allows for secure, command-line based workflows.
2. **Automated Signing**: Once set up, all your commits and tags can be automatically signed.
3. **Simplified Key Management**: GitHub CLI simplifies the process of adding and managing GPG keys on your GitHub account.
```
- add changes push the commit
```bash
git add .
git commit -S -m "Updated README.md"
git push -u origin main
```
**The -S flag in the git commit command is used for signing commits with your GPG key, adding a cryptographic signature to the commit that can be later verified to ensure authenticity.
To verify the GPG signing is working, you can run:
```bash
git log --show-signature -1
```
** This should display a "Good signature" message for the latest commit.

**Set the git configs below to manager dealing with larger Repositories**
- Increase buffer size
```bash
git config --global http.postBuffer 524288000
```
**This increases the buffer to 500MB, which can help with large repositories.**
- Disable compression
```bash
git config --global core.compression 0
```
- Increase timeout
```bash
git config --global http.lowSpeedLimit 1000
git config --global http.lowSpeedTime 300
```

**In the event you still can't download a large repo, try using shallow cloning**
```bash
git clone --depth 1 <repository-url>
cd repo
git fetch --unshallow
```
- Using the Git Large File Storage (LFS) can also help
```bash
git lfs install
git lfs pull
```
