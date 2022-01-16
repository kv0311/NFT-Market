const {ethers} = require('hardhat');
async function main(){
    const FootBall = await ethers.getContractFactory("FootBall");
    const footBall =await FootBall.deploy("FootBall","FBL");
    await footBall.deployed();
    console.log('%j',footBall);

    // console.log("Successfully deployed smart contract to: ", footBall.address().toString());
    await footBall.mint("https://ipfs.io/ipfs/Qmb3CWqhYuHHdHnZQFERBj8FcyREdPiwNEPw9TxFdr94bA");
    console.log("NFT successfully mint")
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });