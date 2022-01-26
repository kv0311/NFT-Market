const {upgrades, ethers} = require('hardhat');
async function main(){
    const [deployer] = await ethers.getSigners();
          console.log("Deploying contracts with the account:", deployer.address);
          const IT = await ethers.getContractFactory("IT");
          const Blockchain = await ethers.getContractFactory("Blockchain");
          const it = await upgrades.deployProxy(IT,[], {kind: "uups"})
            const blockchainSalary = await upgrades.upgradeProxy(it, Blockchain);
            await blockchainSalary.setSalary(100);
            console.log(it.fee);
            console.log(blockchainSalary.fee);
}
    
        
main()
.then(() => process.exit(0))
.catch((error) => {
  console.error(error);
  process.exit(1);
});
