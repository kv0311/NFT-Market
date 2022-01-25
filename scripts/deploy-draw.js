
      // const SVGNFT =  await ethers.getContractFactory("NFTManagement", {
      //   libraries: {
      //     NFTUtils: "0x76dafa79a44215344dc132f6fc6364071299994a",
      //     MultiPartRLEToSVG: "0xde86f7a6e6b97bfe857065e3415ea479de69b9d7"
      //   },
      // });
      
      const { ethers, upgrades, hardhatArguments } = require('hardhat');
      // const { addresses } = require('./proxyAddresses');
      
      const contractName = "NFTManagement";
      
      async function main() {
        const [deployer] = await ethers.getSigners();
      
        const network = hardhatArguments.network;
        const proxyAddress = "0x2fdE5c639Af1Ee51d503584497304F4367d6d29F"
      
        console.log("Deploying contracts with the account:", deployer.address);
      
        const contract = await ethers.getContractFactory(contractName, {
            libraries: {
              NFTUtils: "0x76dafa79a44215344dc132f6fc6364071299994a",
            },
          });
      
        console.log('Upgrading contract...');
        await upgrades.upgradeProxy(proxyAddress, contract);
        console.log('Contract upgraded');
      }
      
      main()
        .then(() => process.exit(0))
        .catch((error) => {
          console.error(error);
          process.exit(1);
        });
  