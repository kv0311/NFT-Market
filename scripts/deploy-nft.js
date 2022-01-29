
      // const SVGNFT =  await ethers.getContractFactory("NFTManagement", {
      //   libraries: {
      //     NFTUtils: "0x76dafa79a44215344dc132f6fc6364071299994a",
      //     MultiPartRLEToSVG: "0xde86f7a6e6b97bfe857065e3415ea479de69b9d7"
      //   },
      // });
      
      const { ethers, upgrades, hardhatArguments } = require('hardhat');
      async function main() {
          const [deployer] = await ethers.getSigners();
        
          console.log("Deploying contracts with the account:", deployer.address);
        
          const NFT = await ethers.getContractFactory("NFTManagement",{
            libraries: {
              NFTUtils: "0x76dafa79a44215344dc132f6fc6364071299994a",
            }
          });
          // const contract = await Descriptor.attach(
          //   "0x6C02710507373E03564FeF82140367b5655Ed6d3" // The deployed contract address
          // );
          // Deploy 100M token
          const nftContract = await NFT.deploy();
        
          const nftContractResult = await nftContract.deployed();
          // await descriptorContractResult.descriptor.addManyBackgrounds(["djs"]);
          // const desc = await descriptorContractResult.descriptor
          console.log('%j',nftContractResult)     // console.log("Contract deployed to:", descriptorContractResult);
        
          // console.log("BUSD Token address:", contractDeploy.address);
        }
        
        main()
          .then(() => process.exit(0))
          .catch((error) => {
            console.error(error);
            process.exit(1);
          });
      
      
        