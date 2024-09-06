# Linking Pass, GPG, and Huggingface

- Install pass using Homebrew
```bash
brew install pass
```
- Initialize pass with your GPG key ID (use the ID of your signing subkey):
```bash
pass init "0x2345678901ABCDEF"
```
- Copy your Huggingface API token from Huggingface.co so it in your pasteboard and then insert it into pass. You will need to do this twice.
## You will NOT see any characters when you paste your token into pass. This is normal.##
```bash
pass insert hf/token
```
- Verify that your huggingface token is stored correctly in pass 
```bash
pass show hf/token
```
- add pass to PATH in your ~/.bashrc or ~/.zshrc
```bash
export HUGGING_FACE_HUB_TOKEN=$(pass show hf/token)
```
- source your shell environments
```bash
source ~/.bashrc 
source ~/.zshrc
```
- use the huggingface-cli to download the qompass r3 model. Make sure you have the safetensors and transformers python libraries installed.
```bash
huggingface-cli login
```
```bash
huggingface-cli download qompass/r3
```
