const {ethers} = require('hardhat');
async function main(){
    try{
      // const MultiPartRLEToSVG = await ethers.getContractFactory("MultiPartRLEToSVG");
      // const multiPartRLEToSVG =await MultiPartRLEToSVG.deploy();
      // const multiPartRLEToSVGResult = await MultiPartRLEToSVG.deployed();
      
      const SVGNFT =  await ethers.getContractFactory("NFTManagement", {
        libraries: {
          NFTUtils: "0x76dafa79a44215344dc132f6fc6364071299994a",
          MultiPartRLEToSVG: "0xde86f7a6e6b97bfe857065e3415ea479de69b9d7"
        },
      });
      const svgNFT =await SVGNFT.deploy();
      let multiPartRLEToSVGResult = await svgNFT.deployed();
    
        // const str1 = await svgNFT.create("123");
        // const str2 = await svgNFT.tokenURI(0);
        // console.log("NFT successfully mint")
       console.log(multiPartRLEToSVGResult)
    } catch (err){
        console.log(err)
    }
    
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });



  