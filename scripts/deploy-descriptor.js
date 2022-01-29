
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
  
    const Descriptor = await ethers.getContractFactory("Descriptor",{
      libraries: {
          MultiPartRLEToSVG: "0x514e3C210c2dAD92A54c9A448174330f744f9108"
        }});
    const descriptorContract = await Descriptor.deploy(Descriptor);
    // Deploy 100M token
    // const descriptorContract = await Descriptor.deploy();
  
    const descriptorContractResult = await descriptorContract.deployed();
  
    console.log("Contract deployed to:", descriptorContractResult);
  
    // console.log("BUSD Token address:", contractDeploy.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });


  