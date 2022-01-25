
      // const SVGNFT =  await ethers.getContractFactory("NFTManagement", {
      //   libraries: {
      //     NFTUtils: "0x76dafa79a44215344dc132f6fc6364071299994a",
      //     MultiPartRLEToSVG: "0xde86f7a6e6b97bfe857065e3415ea479de69b9d7"
      //   },
      // });
      

  async function main() {
    const [deployer] = await ethers.getSigners();
  
    console.log("Deploying contracts with the account:", deployer.address);
  
    console.log("Account balance:", (await deployer.getBalance()).toString());
  
    const BUSDToken = await ethers.getContractFactory("Descriptor",{
      libraries: {
        MultiPartRLEToSVG: "0xde86f7a6e6b97bfe857065e3415ea479de69b9d7"
      }
    });
    // Deploy 100M token
    const contractDeploy = await BUSDToken.deploy();
  
    const deployContract = await contractDeploy.deployed();
  
    console.log("Contract deployed to:", deployContract);
  
    // console.log("BUSD Token address:", contractDeploy.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });


  