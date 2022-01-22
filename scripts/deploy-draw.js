const {ethers} = require('hardhat');
async function main(){
    try{
      // const SVGNFTDraw = await ethers.getContractFactory("DrawSVG");
      // const svgNFTDraw =await SVGNFTDraw.deploy();
      // const svgNFTDrawResult = await svgNFTDraw.deployed();
      
      const SVGNFT =  await ethers.getContractFactory("SVGNFT", {
        libraries: {
          DrawSVG: "0x5453b7a888ad291137c578ae49cb85e97a3727b9"
        },
      });
      const svgNFT =await SVGNFT.deploy();
      await svgNFT.deployed();
    
        // const str1 = await svgNFT.create("123");
        // const str2 = await svgNFT.tokenURI(0);
        // console.log("NFT successfully mint")
       console.log(svgNFT)
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



  