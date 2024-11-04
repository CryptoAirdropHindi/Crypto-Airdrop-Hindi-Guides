#!/bin/bash

echo ""
curl -s https://raw.githubusercontent.com/CryptoAirdropHindi/Crypto-Airdrop-Hindi-Guides/main/logo.sh
sleep 2

# Create target directory for extraction
mkdir -p target/release

# Download and extract BlockMesh CLI
echo "Downloading and extracting BlockMesh CLI..."
curl -L https://github.com/block-mesh/block-mesh-monorepo/releases/download/v0.0.324/blockmesh-cli-x86_64-unknown-linux-gnu.tar.gz -o blockmesh-cli.tar.gz
tar -xzf blockmesh-cli.tar.gz --strip-components=3 -C target/release

# Verify extraction
if [[ ! -f target/release/blockmesh-cli ]]; then
    echo "Error: blockmesh-cli binary not found in target/release. Exiting..."
    exit 1
fi

# Prompt for email and password
read -p "Enter your BlockMesh email: " email
read -s -p "Enter your BlockMesh password: " password
echo

# Run the Docker container with the BlockMesh CLI
echo "Creating a Docker container for the BlockMesh CLI..."
docker run -it --rm \
    --name blockmesh-cli-container \
    -v $(pwd)/target/release:/app \
    -e EMAIL="$email" \
    -e PASSWORD="$password" \
    --workdir /app \
    ubuntu:22.04 ./blockmesh-cli --email "$email" --password "$password"
