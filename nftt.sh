#!/bin/sh

wget -O loader.sh https://raw.githubusercontent.com/DiscoverMyself/Ramanode-Guides/main/loader.sh && chmod +x loader.sh && ./loader.sh
sleep 4

sudo apt-get update && sudo apt-get upgrade -y
clear

echo "Installing dependencies..."
npm install --save-dev hardhat
npm install dotenv
npm install @swisstronik/utils
npm install @openzeppelin/contracts
echo "Installation completed."

echo "Creating a Hardhat project..."
npx hardhat

rm -f contracts/Lock.sol
echo "Lock.sol removed."

echo "Hardhat project created."

echo "Installing Hardhat toolbox..."
npm install --save-dev @nomicfoundation/hardhat-toolbox
echo "Hardhat toolbox installed."

echo "Creating .env file..."
read -p "Enter your private key: " PRIVATE_KEY
echo "PRIVATE_KEY=$PRIVATE_KEY" > .env
echo ".env file created."

echo "Configuring Hardhat..."
cat <<EOL > hardhat.config.js
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    swisstronik: {
      url: "https://json-rpc.testnet.swisstronik.com/",
      accounts: [\`0x\${process.env.PRIVATE_KEY}\`],
    },
  },
};
EOL
echo "Hardhat configuration completed."

read -p "Enter the NFT name: " NFT_NAME
read -p "Enter the NFT symbol: " NFT_SYMBOL

echo "Creating NFT.sol contract..."
mkdir -p contracts
cat <<EOL > contracts/NFT.sol
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC7
