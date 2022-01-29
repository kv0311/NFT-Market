
// const SVGNFT =  await ethers.getContractFactory("NFTManagement", {
//   libraries: {
//     NFTUtils: "0x348FdbFe53E51dABfD5Bf2993437eb41DD214735",
//     MultiPartRLEToSVG: "0xebd42256b90f002d19c8f2ed4eed406765759f57"
//   },
// });

const { ethers, upgrades, hardhatArguments } = require('hardhat');
async function main() {
    const [deployer] = await ethers.getSigners();


    const NFTUtils = await ethers.getContractFactory("NFTUtils");
    const nftUtils = await NFTUtils.deploy();
    const nftResult = await nftUtils.deployed();
    console.log("Deploying nft with the account:", nftResult.address);

    //  const MultiPartRLEToSVG = await ethers.getContractFactory("MultiPartRLEToSVG");
    // const multiPartRLEToSVG = await MultiPartRLEToSVG.deploy();
    // const multiPartRLEToSVGResult = await multiPartRLEToSVG.deployed();
    // console.log("Deploying multipart with the account:", multiPartRLEToSVGResult);
      const Descriptor = await ethers.getContractFactory("AllIn",{
        libraries: {
            NFTUtils: nftResult.address,
            // MultiPartRLEToSVG: "0xebd42256b90f002d19c8f2ed4eed406765759f57"
          }
        });
    //   const descriptorContract = await Descriptor.deploy();
    //   Deploy 100M token
      const descriptorContract = await Descriptor.deploy();

      const descriptorContractResult = await descriptorContract.deployed();

      console.log("Contract all in deployed to:", descriptorContractResult.address);

    // console.log("BUSD Token address:", contractDeploy.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });


