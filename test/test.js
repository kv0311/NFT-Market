const hre = require('hardhat');
const { expect } = require('chai')
describe('Box (proxy)', function () {
before('get factory', async function(){
    this.IT = hre.ethers.getContractFactory("IT");
    this.BlockchainSalary = hre.ethers.getContractFactory("BlockchainSalary");
})
it('goes to moon', async function(){
    const it = await hre.upgrades.deployProxy(this.IT, {kind: 'upps'});
    const blockchainSalary = await hre.upgrades.upgradeProxy(it, this.BlockchainSalary);
    await blockchainSalary.setSalary(100);
    console.log(it.fee);
    console.log(blockchainSalary.fee);
})
})