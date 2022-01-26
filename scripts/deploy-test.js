
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
        
          const Descriptor = await ethers.getContractFactory("IT");
          const Blockchain = await ethers.getContractFactory("Blockchain");

        //   const descriptor = await upgrades.deployProxy(Descriptor, {kind: "uups"})
          const blockchain = await upgrades.upgradeProxy("0xa975cBA8De7324C054Bfd76Eb1f9DA73477C5afa", Blockchain);
          console.log(blockchain);
        
          // console.log("BUSD Token address:", contractDeploy.address);
        }
        
        main()
          .then(() => process.exit(0))
          .catch((error) => {
            console.error(error);
            process.exit(1);
          });
      
      
        