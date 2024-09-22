# Linking Pass, GPG, and Huggingface

- Install pass
```MacOS
brew install pass
```

```Arch | WSL2 Arch
sudo pacman -S pass
```

```Ubuntu/Debian | WSL2 Ubuntu/Debian
- Initialize pass with your GPG key ID (use the ID of your signing subkey):
```

```MacOS | WSL2 | Linux
pass init "0x2345678901ABCDEF"
```

- Copy your Huggingface API token from Huggingface.co so it in your pasteboard and then insert it into pass. You will need to do this twice.

## You will NOT see any characters when you paste your token into pass. This is normal.##

```MacOS | WSL2 | Linux
pass insert hf
```

- Verify that your huggingface token is stored correctly in pass

```MacOS | WSL2 | Linux
pass show hf/token
```

- add pass to PATH in your ~/.bashrc or ~/.zshrc

```MacOS | WSL2 | Linux
export HUGGING_FACE_HUB_TOKEN=$(pass show hf)
```

- source your shell environments

```MacOS | WSL2 | Linux
source ~/.bashrc 
source ~/.zshrc
```

- use the huggingface-cli to download the qompass r3 model.
- **Make sure you have the safetensors and transformers python libraries installed.**

```MacOS | WSL2 | Linux
pip install -U safetensors transformers
huggingface-cli login
```

- Read the huggingface model card for qompass/r3 at https://huggingface.co/qompass/r3
- Use the huggingface cli to download the model weights.

```MacOS | WSL2 | Linux
huggingface-cli download qompass/r3
```

- This will take a good amount of time to download. Look up anything that is unfamiliar from the model card.

## Level 4 Finish Line

- You've just downloaded your first AI model. Congrats, you're officially ahead of 99.9% of your peers. And most professionals.
