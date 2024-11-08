#!/bin/bash

REPO="ollama/ollama"
ARCH=$(uname -m)
OS=$(uname -s)

if ! command -v brew &> /dev/null; then
    printf "Homebrew is not installed. Please install Homebrew and run this script again.\n"
    exit 1
fi

if ! command -v go &> /dev/null; then
    printf "Installing Go...\n"
    brew install go
    if [ $? -ne 0 ]; then
        printf "Failed to install Go. Exiting.\n"
        exit 1
    fi
fi
printf "Go installed successfully.\n"

printf "Installing Lua, Luarocks, and LuaJIT...\n"
brew install lua@5.1 luajit luarocks neovim

if [ $? -ne 0 ]; then
    printf "Failed to install Lua, Luarocks, or Neovim. Ensure Homebrew is installed and try again.\n"
    exit 1
fi
printf "Lua, LuaJIT, Luarocks, and Neovim installed successfully.\n"

printf "Installing nvim-neotest via Luarocks...\n"
luarocks install nvim-neotest

if [ $? -ne 0 ]; then
    printf "Failed to install nvim-neotest.\n"
    exit 1
fi
printf "nvim-neotest installed successfully.\n"

printf "Installing npm and language servers...\n"
brew install npm

npm install -g typescript typescript-language-server lua-fmt prettier eslint \
                bash-language-server pyright vscode-langservers-extracted

printf "Language servers installed.\n"

printf "Installing Docker, Podman, Docker Compose, and container tooling...\n"
brew install docker podman docker-compose kubectl kind minikube cmake ninja

printf "Setting up Docker and Podman...\n"
brew services start docker
brew services start podman

if ! podman-compose --version &>/dev/null; then
    printf "Installing Podman Compose...\n"
    brew install podman-compose
fi

printf "Setting up Kubernetes tools with Minikube and Kind...\n"
minikube config set driver docker
if ! minikube version &>/dev/null; then
    printf "Minikube setup failed. Exiting.\n"
    exit 1
fi
printf "Kubernetes tools set up with Minikube and Kind.\n"

printf "Cloning the latest compatible release of Ollama repository from GitHub...\n"
if [ ! -d "ollama" ]; then
    git clone --recurse-submodules https://github.com/$REPO.git
    cd ollama || exit
    git fetch --all
    git checkout $(git describe --tags `git rev-list --tags --max-count=1`)
    git submodule update --init --recursive
else
    cd ollama || exit
    git fetch --all
    git checkout $(git describe --tags `git rev-list --tags --max-count=1`)
    git submodule update --init --recursive
fi
printf "Cloned and checked out the latest release of Ollama with updated submodules.\n"

printf "Building Ollama from source with Go and Metal optimizations...\n"
if [[ "$ARCH" == "arm64" && "$OS" == "Darwin" ]]; then
    export CGO_ENABLED=1
    export GOARCH=arm64
    export GOOS=darwin
    export CFLAGS="-framework Metal"
fi

go build -o ollama

if [ $? -ne 0 ]; then
    printf "Go build failed. Please check dependencies.\n"
    exit 1
fi
printf "Go build successful.\n"

printf "Building Ollama with Docker, optimized for Apple Silicon...\n"
docker buildx build --platform linux/arm64 -t ollama:latest .

if [ $? -ne 0 ]; then
    printf "Docker build failed. Ensure Docker is set up for Apple Silicon.\n"
    exit 1
fi
printf "Docker build successful.\n"

printf "Downloading specified versions of IBM Granite models with Ollama...\n"
MODEL_NAMES=("granite3-moe:1b" "granite-code:3b" "granite3-moe:1b" "llama3.2:1b" "smol2:135m" "granite3-guardian:2b" "smollm2:135m")

for model in "${MODEL_NAMES[@]}"; do
    ./ollama model install "$model"
    if [ $? -ne 0 ]; then
        printf "Failed to install model: %s. Continuing with other models...\n" "$model"
    else
        printf "Model %s installed successfully.\n" "$model"
    fi
done

printf "All tasks completed. Ollama is built from source, Lua environment is configured, Neovim testing tools are set, and specified IBM Granite models are installed where possible.\n"
printf "\nQompass PathFinder Maya Steltzer is ready to chart a path towards a successful IBM internship this summer!\n"

