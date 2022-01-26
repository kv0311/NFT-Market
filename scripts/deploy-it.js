
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
        
          const IT = await ethers.getContractFactory("IT");
          const Blockchain = await ethers.getContractFactory("Blockchain");

          const it = await upgrades.deployProxy(IT, {kind: "uups"})
        //   const blockchain = await upgrades.upgradeProxy("0x960de8711c678e4621cc0a08de4dde5e56ad034c", Blockchain);
          console.log(it);
        
          // console.log("BUSD Token address:", contractDeploy.address);
        }
        
        main()
          .then(() => process.exit(0))
          .catch((error) => {
            console.error(error);
            process.exit(1);
          });
      
      
        