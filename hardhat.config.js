const dotenv = require('dotenv')
dotenv.config()
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require('@nomiclabs/hardhat-ethers');
require('@openzeppelin/hardhat-upgrades');

const {  PRIVATE_KEY } = process.env;
// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 module.exports = {
  defaultNetwork: "mainnet",
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545"
    },
    hardhat: {
    },
    testnet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      chainId: 97,
      gasPrice: 20000000000,
      accounts: [`0x${PRIVATE_KEY}`],
    },
    mainnet: {
      url: "https://bsc-dataseed.binance.org/",
      chainId: 56,
      gasPrice: 20000000000,
      accounts: [`0x${PRIVATE_KEY}`],
    },
    rinkeby: {
      url: "https://speedy-nodes-nyc.moralis.io/3ff17d7d4b11fbfa8d5cb8fc/eth/rinkeby",
      accounts: [`0x${PRIVATE_KEY}`],
      gas: 210000000,
      gasPrice: 8000000000000,
    },
    matic: {
      url: "https://matic-mumbai.chainstacklabs.com/",
      accounts: [`0x${PRIVATE_KEY}`],
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: "GMI123VW5CAHJP2T93GYZE4913SFQ5HAJV"
  },
  solidity: {
  version: "0.8.6",
  settings: {
    optimizer: {
      enabled: true
    }
   }
  },
  mocha: {
    timeout: 20000
  }
};