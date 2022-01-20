const {ethers} = require('hardhat');
async function main(){
    try{
        const SVGNFT = await ethers.getContractFactory("Final");
        const svgNFT =await SVGNFT.deploy();
        await svgNFT.deployed();
    
        const str1 = await svgNFT.create("123");
        const str2 = await svgNFT.tokenURI(0);
        console.log("NFT successfully mint")
       console.log(str1)
       console.log(str2)

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


  let d =[["60","10","100","110","d19a54"],["60","10","170","110","d19a54"],["10","10","100","120","d19a54"],["20","10","110","120","d19a54"],["20","10","130","120","000000"],["10","10","150","120","d19a54"],["10","10","170","120","d19a54"],["20","10","180","120","ffffff"],["20","10","200","120","000000"],["10","10","220","120","d19a54"],["40","10","70","30","19a54" ],["20","10","110","130","ffffff"],["20","10","130","130","000000"],["30","10","150","130","d19a54"],["20","10","180","130","ffffff"],["20","10","200","130","000000"],["10","10","220","130","d19a54"],["10","10","70","40","19a54" ],["10","10","100","140","d19a54"],["20","10","110","140","ffffff"],["20","10","130","140","000000"],["10","10","150","140","d19a54"],["10","10","170","140","d19a54"],["20","10","180","140","ffffff"],["20","10","200","140","000000"],["10","10","220","140","d19a54"],["10","10","70","50","19a54" ],["10","10","100","150","d19a54"],["20","10","110","150","ffffff"],["20","10","130","150","000000"],["10","10","150","150","d19a54"],["10","10","170","150","d19a54"],["20","10","180","150","ffffff"],["20","10","200","150","000000"],["10","10","220","150","d19a54"],["60","10","100","160","d19a54"],["60","10","170","160","d19a54"]]