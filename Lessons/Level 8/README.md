# Quanting small models

## Set your paths for HF models and datasets and download the HF model with hf-cli

```bash
huggingface-cli download ibm-granite/granite-3.0-1b-a400m-base --local-dir ./granite-model --resume

```

### MacOS

### Check Metal support

```zsh
nm main | grep Metal
```

```zsh
brew install cmake
xcode-select --install
git clone https://github.com/ggerganov/llama.cpp.git
cd llama.cpp
mkdir build
cd build
cmake .. -DLLAMA_METAL=ON
cmake --build . --config Release
```

- or

```zsh
cmake .. -DCMAKE_CXX_FLAGS="-framework Metal -framework MetalPerformanceShaders"

cmake .. -DCMAKE_CXX_FLAGS="-O3 -framework Metal -framework MetalPerformanceShaders"


```

### Simple python script to quantize the model

```zsh
from transformers import AutoModelForCausalLM

# Load model
model_name = "ibm-granite/granite-3.0-1b-a400m-base"
model = AutoModelForCausalLM.from_pretrained(model_name)

# Save model in standard PyTorch format
model.save_pretrained("./granite-model")

```

### Convert the model to Grokking Gradient Unified Format (GGUF)

```zsh
python convert.py --input_dir ./granite-model --output_dir ./granite-model-gguf --format gguf
```

### Quantize the GGUF model

```zsh
./quantize ./granite-model-gguf/f16.gguf ./granite-model-gguf/quantized.gguf q4_0
```
