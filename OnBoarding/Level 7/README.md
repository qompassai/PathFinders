# Level 7: Aligning databases and languages for production

- Straigthtforward and simple -
  add the .rc files to your ~ directory and source them to streamline your building.

## Download packages to support duckdb build

### MacOS

```zsh
brew install llvm cmake python rust go node postgresql make
```

### MacOS

```python
# Testing with macOS 13.5 Apple Silicon (Arm) Python 3.12.3, YMMV
xcode-select --install
pip3 install \
    'accelerate[testing,dev]' \
    'aiohttp' \
    'beautifulsoup4' \
    'boto3' \
    'catboost' \
    'croissant-ml[all]' \
    'datasets[streaming,audio,vision]' \
    'diffusers[torch]' \
    'duckdb' \
    'fsspec[http,s3]' \
    'functime' \
    'gensim' \
    'huggingface-hub[cli,torch,dev,testing,quality]' \
    'ibis-framework[duckdb,postgres,sqlite]' \
    'ibm-platform-services' \
    'ibm-watsonx-ai' \
    'ipykernel' \
    'ipysheet' \
    'ipywidgets' \
    'itables' \
    'jupyter' \
    'jupyterlab' \
    'jupyterlab-execute-time' \
    'jupyterlab-git' \
    'jupyterlab-lsp' \
    'jupyterlab-spellchecker' \
    'jupyterlab_vim' \
    'matplotlib' \
     'mlx' \
     'mlx-lm' \
     'mlx-vision' \
     'metal-compute' \
     'metal-sdk' \
    'mysql-connector-python' \
    'nltk' \
    'numpy' \
    'opencv-python' \
    'optimum[exporters,onnxruntime]' \
    'pandas[performance,computation,aws]' \
    'pillow' \
    'plotly' \
    'polars[all]' \
    'psycopg2-binary' \
    'pyarrow' \
    'pydantic' \
    'pynvim' \
    'requests' \
    'rustimport' \
    'sacremoses' \
    'safetensors' \
    'scikit-learn' \
    'scipy' \
    'seaborn' \
    'seaborn-polars' \
    'selenium' \
    'sentencepiece' \
    'sqlalchemy' \
    'tokenizers' \
    'torch' \
    'transformers'
    
```

```text
accelerate: Speeds up PyTorch training on Apple Silicon/CPU
aiohttp: Async HTTP client/server framework for API calls and web requests
beautifulsoup4: HTML/XML parser for web scraping and data extraction
boto3: AWS SDK for Python, handles S3 and AWS services
catboost: Gradient boosting library for fast, accurate ML models
croissant-ml: ML dataset format and tools for standardized data handling
datasets: Hugging Face's data loading/processing library with streaming support
diffusers: Stable Diffusion and other generative AI model toolkit
duckdb: Fast analytical SQL database engine for local data analysis
fsspec: Filesystem abstraction for cloud storage (S3, HTTP) access
functime: Time series forecasting and analysis toolkit
gensim: Topic modeling and document similarity analysis
huggingface-hub: Interface to HuggingFace's model/dataset repository
ibis-framework: SQL query engine that works with DuckDB/PostgreSQL
ibm-platform-services: IBM Cloud service APIs
ibm-watsonx-ai: IBM's watsonx.ai foundation model API client
ipykernel: IPython kernel for Jupyter notebooks
ipysheet: Excel-like spreadsheets in Jupyter notebooks
ipywidgets: Interactive widgets for Jupyter notebooks
itables: Interactive tables in Jupyter notebooks
jupyter: Web-based notebook environment for interactive computing
jupyterlab: Modern interface for Jupyter with extensions
jupyterlab-execute-time: Shows cell execution time in JupyterLab
jupyterlab-git: Git integration for JupyterLab
jupyterlab-lsp: Code intelligence for JupyterLab (autocomplete, hints)
jupyterlab-spellchecker: Spell checking in JupyterLab markdown/comments
jupyterlab_vim: Vim keybindings in JupyterLab
matplotlib: Standard plotting library for Python
metal-compute: Apple Metal GPU compute framework for ML acceleration
mlx: Apple's ML framework optimized for Apple Silicon
mlx-lm: Language models optimized for MLX framework
mlx-vision: Computer vision models optimized for MLX
mysql-connector-python: MySQL database connector
nltk: Natural Language Processing toolkit
numpy: Numerical computing foundation library
opencv-python: Computer vision and image processing library
optimum: Hugging Face's model optimization toolkit
pandas: Data manipulation and analysis library
pillow: Python Imaging Library for image processing
plotly: Interactive plotting library
polars: Fast DataFrame library alternative to pandas
psycopg2-binary: PostgreSQL database adapter
pyarrow: Apache Arrow data format implementation
pydantic: Data validation using Python type annotations
pynvim: Neovim integration for Python
requests: HTTP library for API calls
rustimport: Import Rust code in Python
sacremoses: Moses tokenizer implementation
safetensors: Fast tensor serialization library
scikit-learn: Machine learning algorithms library
scipy: Scientific computing library
seaborn: Statistical data visualization
seaborn-polars: Seaborn integration with Polars DataFrames
selenium: Browser automation tool
sentencepiece: Text tokenizer for ML models
sqlalchemy: SQL toolkit and ORM
tokenizers: Fast tokenizers for NLP
torch: PyTorch deep learning framework (CPU/MPS for Apple Silicon)
transformers: Hugging Face's transformer models library
```

### Linux | MSFT WSL

```python
# Used Python 3.12.7 /usr/bin/python x86_64 linux-gnu, YMMV
pip3 install \
    'accelerate[testing,dev]' \
    'aiohttp' \
    beautifulsoup4 \
    boto3 \
    catboost \
    'croissant-ml[all]' \
    'datasets[streaming,audio,vision,tensorflow,torch]' \
    'diffusers[torch]' \
    duckdb \
    'fsspec[http,s3,gcs]' \
    functime \
    gensim \
    'huggingface-hub[cli,torch,tensorflow,dev,testing,quality,hf_transfer]' \
    httpfs \
    ibis-framework \
    ibm-platform-services \
    ibm-watsonx-ai \
    ipykernel \
    ipysheet \
    ipywidgets \
    itables \
    jaxlib \
    jupyter \
    jupyterlab \
    jupyterlab-execute-time \
    jupyterlab-git \
    jupyterlab-lsp \
    jupyterlab-spellchecker \
    jupyterlab_vim \
    keras \
    lightning \
    lit \
    matplotlib \
    mysql-connector-python \
    nltk \
    numpy \
    'opencv-python-headless' \
    'optimum[exporters,onnxruntime-gpu]' \
    'pandas[performance,computation,aws,gcp,azure]' \
    pennylane \
    'pennylane-lightning[gpu]' \
    pennylane-qiskit \
    pgai \
    pillow \
    plotly \
    'polars[all]' \
    psycopg2-binary \
    pyarrow \
    pydantic \
    pynvim \
    pyo3-pack \
    pyside2 \
    qiskit \
    qiskit-aer-gpu \
    qiskit-ignis \
    requests \
    rustimport \
    sacremoses \
    safetensors \
    'scikit-learn-intelex' \
    scipy \
    seaborn \
    seaborn-polars \
    selenium \
    sentencepiece \
    spatial \
    sqlalchemy \
    tokenizers \
    torch torchvision torchaudio \
    transformers \
    zebras \
    'jax[cuda]' \
    tensorflow 

# Additional NVIDIA packages
pip3 install \
    nvidia-cuda-runtime-cu12 \
    nvidia-cuda-cupti-cu12 \
    nvidia-cuda-nvcc-cu12 \
    nvidia-cuda-nvrtc-cu12 \
    nvidia-cublas-cu12 \
    nvidia-cufft-cu12 \
    nvidia-curand-cu12 \
    nvidia-cusolver-cu12 \
    nvidia-cusparse-cu12 \
    nvidia-nccl-cu12 \
    nvidia-cudnn-cu12 \
    nvidia-dali-cuda120 \
    nvidia-pyindex

```

```bash
gh repo clone duckdb/duckdb
cd duckdb
git fetch --tags
git tag | sort -V | tail -n 1
git checkout v1.1.2 # or latest release version
```

- Verify integrity of the repo with all the extensions we will be building:

```duckdb
- **autocomplete**: Adds SQL autocompletion to enhance the DuckDB interactive experience.
- **excel**: Enables reading/writing Excel files (`.xls` and `.xlsx`).
- **fts**: Adds Full-Text Search for efficient text columns searching in DuckDB tables.
- **httpfs**: Supports reading/writing data from remote sources (HTTP/HTTPS/URLs).
- **icu**: Integrates ICU for advanced string manipulation, collation, and internationalization.
- **inet**: Adds functions for handling IP addresses for analyzing network data.
- **jemalloc**: Uses `jemalloc` allocator to improve large workload memory performance.
- **json**: Adds support for reading, writing, and querying JSON data within DuckDB.
- **parquet**: Enables reading/writing Parquet files used in data science & AI. 
- **sqlsmith**: Provides SQL query generation for stress testing/validating SQL engine.
- **tpcds**: Implements TPC-DS benchmarks for evaluating decision support workloads.
- **tpch**: Implements TPC-H benchmarks for analytical tasks evaluation. 
- **visualizer**: Visualizes query execution plans to understand query performance.
```

```sh
# After cloning the DuckDB repo
cd duckdb
ls extension
```

- You should see:

`autocomplete  excel  fts  httpfs  icu  inet  jemalloc  json  parquet  sqlsmith  tpcds  tpch  visualizer`

## Build From Source

## MacOS | Linux | MSFT WSL2

**In the main DuckDB directory you cloned from github**

- 1. Build Option 1: Make (Most common)

```bash

sudo CORE_EXTENSIONS='arrow;autocomplete;fts;httpfs;icu;json;parquet;spatial;tpch;tpcds' GEN=ninja make
sudo cp build/release/duckdb /usr/local/bin/
```

- 2. Build Option 2: CMake/LLVM/Ninija

```bash
mkdir -p build
cd build

sudo cmake -G Ninja .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DBUILD_EXTENSIONS="autocomplete;httpfs;icu;parquet;json;fts;tpch;tpcds;jemalloc"
ninja
cd extension/
for EXTENSION in *; do
    ../duckdb -c "INSTALL '${EXTENSION}/${EXTENSION}.duckdb_extension';"
done

```

- Build Option 3: fine-grained config Cmake/LLVM

```bash
# Create an extension_config.cmake file in the main duckdb directory based on use-case
duckdb_extension_load(autocomplete)
duckdb_extension_load(fts)
duckdb_extension_load(httpfs)
duckdb_extension_load(icu)
duckdb_extension_load(json)
duckdb_extension_load(parquet)
duckdb_extension_load(tpch)
duckdb_extension_load(tpcds)
duckdb_extension_load(jemalloc)

# Then create build dir and add extension_config
mkdir -p build && cd build
sudo cmake -G Ninja .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DDUCKDB_EXTENSION_CONFIGS="extension_config.cmake"
sudo ninja install

```

```bash

# Create a new file extension_config.cmake in the root directory with updated syntax:

include(FetchContent)

# Arrow Extension
FetchContent_Declare(
    arrow_EXTENSION_FC
    GIT_REPOSITORY https://github.com/duckdb/arrow
    GIT_TAG c50862c
)
FetchContent_MakeAvailable(arrow_EXTENSION_FC)
duckdb_extension_load(arrow)

# Spatial Extension
FetchContent_Declare(
    spatial_EXTENSION_FC
    GIT_REPOSITORY https://github.com/duckdb/spatial
    GIT_TAG main
)
FetchContent_MakeAvailable(spatial_EXTENSION_FC)
duckdb_extension_load(spatial)



```

```bash
cmake -G Ninja .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DEXTENSION_STATIC_BUILD=1 \
    -DCMAKE_CXX_FLAGS="-Wno-deprecated" \
    -DCMAKE_POLICY_DEFAULT_CMP0169=NEW

```

## Verify build with extensions

### MacOS | Linux | MSFT WSL2

- Open a new shell and check duckdb version

```duckdb
duckdb --version

```

```duckdb
SELECT * FROM duckdb_extensions() 
WHERE loaded = true;
```
