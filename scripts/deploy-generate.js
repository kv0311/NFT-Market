const { ethers, upgrades, hardhatArguments } = require('hardhat');
async function main() {
    const [deployer] = await ethers.getSigners();

const NFTUtils = await ethers.getContractFactory("NFTUtils");
    const nftUtils = await NFTUtils.deploy();
    const nftResult = await nftUtils.deployed();
    console.log("Deploying nft utils with the account:", nftResult.address);

    const NounsSeeder = await ethers.getContractFactory("NounsSeeder");
    const nounsSeeder = await NounsSeeder.deploy();
    const nounsSeederResult = await nounsSeeder.deployed();
    console.log("Deploying nouns seeder with the account:", nounsSeederResult.address);

    const NounsDescriptor = await ethers.getContractFactory("Descriptor");
    const nounsDescriptor = await NounsDescriptor.deploy();
    const nounsDescriptorResult = await nounsDescriptor.deployed();
    console.log("Deploying nouns descriptor with the account:", nounsDescriptorResult.address);

    const NounsNftManagement = await ethers.getContractFactory("NFTManagement",{
        libraries: {
            NFTUtils: nftResult.address,
            // MultiPartRLEToSVG: "0xebd42256b90f002d19c8f2ed4eed406765759f57"
          }
        });
    const nounsNftManagement = await NounsNftManagement.deploy("0xEBd42256B90f002d19C8f2ed4Eed406765759F57",nounsDescriptorResult.address,nounsSeederResult.address );
    const nounsNftManagementResult = await nounsNftManagement.deployed();
    console.log("Deploying nouns nft management with the account:", nounsNftManagementResult.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });

