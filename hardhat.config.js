require("dotenv");

require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require('@nomiclabs/hardhat-ethers');

require('@openzeppelin/hardhat-upgrades');
require("dotenv")
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
      gas: 2100000,
      gasPrice: 8000000000,
      accounts: {mnemonic: "empty jewel nose viable pink leader mad review witness camp into expire"}
    },
    mainnet: {
      url: "https://bsc-dataseed.binance.org/",
      chainId: 56,
      gasPrice: 20000000000,
      accounts: {mnemonic: "empty jewel nose viable pink leader mad review witness camp into expire"}
    },
    rinkeby: {
      url: "https://speedy-nodes-nyc.moralis.io/3ff17d7d4b11fbfa8d5cb8fc/eth/rinkeby",
      accounts: {mnemonic: "empty jewel nose viable pink leader mad review witness camp into expire"},
      gas: 210000000,
      gasPrice: 8000000000000,
    },
    matic: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: {mnemonic: "empty jewel nose viable pink leader mad review witness camp into expire"},
    }
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