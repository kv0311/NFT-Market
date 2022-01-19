pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "base64-sol/base64.sol";
contract SVGNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;
    event CreatedSVGNFT(uint256 indexed tokenId, string tokenURI);
    struct RectInfo {
            string width;
            string height;
            string x;
            string y;
            string fill;
    }
    string[][] public body;
    string[][] public head;
    string[][] public accessory;
    string[][] public glasses;

    RectInfo[] public rectInfoList;
    constructor() ERC721("SVG NFT", "svgNFT")
    {
        tokenCounter = 0;
    }
    // [["140","10","90","210","eed811"],["140","10","90","220","eed811"],["140","10","90","230","eed811"],["140","10","90","240","eed811"],["20","10","90","250","eed811"],["110","10","120","250","eed811"],["20","10","90","260","eed811"],["110","10","120","260","eed811"],["20","10","90","270","eed811"],["110","10","120","270","eed811"],["20","10","90","280","eed811"],["110","10","120","280","eed811"],["20","10","90","290","eed811"],["110","10","120","290","eed811"],["20","10","90","300","eed811"],["110","10","120","300","eed811"],["20","10","90","310","eed811"],["110","10","120","310","eed811"]]
    function addBody( string[][] memory _body) public returns (string[][] memory){
        body = _body;
    }

    //[["30","10","150","30","fb4694"],["10","10","160","40","fb4694"],["60","10","130","50","fb4694"],["100","10","110","60","fb4694"],["140","10","90","70","2b83f6"],["100","10","80","80","2b83f6"],["10","10","180","80","caeff9"],["10","10","190","80","2b83f6"],["20","10","200","80","caeff9"],["20","10","220","80","2b83f6"],["120","10","80","90","2b83f6"],["20","10","200","90","caeff9"],["20","10","220","90","2b83f6"],["180","10","70","100","2b83f6"],["180","10","70","110","2b83f6"],["180","10","70","120","2b83f6"],["200","10","60","130","2b83f6"],["200","10","60","140","2b83f6"],["200","10","60","150","2b83f6"],["200","10","60","160","fb4694"],["240","10","40","170","fb4694"],["50","10","30","180","fb4694"],["20","10","80","180","ffe939"],["10","10","100","180","fb4694"],["20","10","110","180","ffe939"],["10","10","130","180","fb4694"],["20","10","140","180","ffe939"],["10","10","160","180","fb4694"],["20","10","170","180","ffe939"],["10","10","190","180","fb4694"],["20","10","200","180","ffe939"],["10","10","220","180","fb4694"],["20","10","230","180","ffe939"],["40","10","250","180","fb4694"],["60","10","20","190","fb4694"],["20","10","80","190","ffe939"],["10","10","100","190","fb4694"],["20","10","110","190","ffe939"],["10","10","130","190","fb4694"],["20","10","140","190","ffe939"],["10","10","160","190","fb4694"],["20","10","170","190","ffe939"],["10","10","190","190","fb4694"],["20","10","200","190","ffe939"],["10","10","220","190","fb4694"],["20","10","230","190","ffe939"],["50","10","250","190","fb4694"],["200","10","60","200","fb4694"],["100","10","110","210","fb4694"]]
    function addHead( string[][] memory _head) public returns (string[][] memory){
        head = _head;
    }

    //[["60","10","100","110","d19a54"],["60","10","170","110","d19a54"],["10","10","100","120","d19a54"],["20","10","110","120","d19a54"],["20","10","130","120","000000"],["10","10","150","120","d19a54"],["10","10","170","120","d19a54"],["20","10","180","120","ffffff"],["20","10","200","120","000000"],["10","10","220","120","d19a54"],["40","10","70","130","19a54" ],["20","10","110","130","ffffff"],["20","10","130","130","000000"],["30","10","150","130","d19a54"],["20","10","180","130","ffffff"],["20","10","200","130","000000"],["10","10","220","130","d19a54"],["10","10","70","140","19a54" ],["10","10","100","140","d19a54"],["20","10","110","140","ffffff"],["20","10","130","140","000000"],["10","10","150","140","d19a54"],["10","10","170","140","d19a54"],["20","10","180","140","ffffff"],["20","10","200","140","000000"],["10","10","220","140","d19a54"],["10","10","70","150","19a54" ],["10","10","100","150","d19a54"],["20","10","110","150","ffffff"],["20","10","130","150","000000"],["10","10","150","150","d19a54"],["10","10","170","150","d19a54"],["20","10","180","150","ffffff"],["20","10","200","150","000000"],["10","10","220","150","d19a54"],["60","10","100","160","d19a54"],["60","10","170","160","d19a54"]]
    function addGlasses( string[][] memory _glasses) public returns (string[][] memory){
        glasses = _glasses;
    }
// [["70","10","130","240","26b1f3"],["10","10","130","250","26b1f3"],["10","10","150","250","26b1f3"],["10","10","170","250","26b1f3"],["30","10","190","250","26b1f3"],["30","10","130","260","26b1f3"],["30","10","170","260","26b1f3"],["10","10","210","260","26b1f3"]]
    function addAccessory( string[][] memory _accessory) public returns (string[][] memory){
        accessory = _accessory;
    }
    
    function createRect() public returns (string memory){
        
        string memory chunk;

        for (uint256 i = 0; i < body.length; i += 1) {
            chunk = string(
                abi.encodePacked(
                    chunk,
                    '<rect width="', body[i][0], '" height="', body[i][1], '" x="', body[i][2], '" y="', body[i][3], '"  fill="#', body[i][4], '"/>'
                )
            );
        }

        for (uint256 i = 0; i < head.length; i += 1) {
            chunk = string(
                abi.encodePacked(
                    chunk,
                    '<rect width="', head[i][0], '" height="', head[i][1], '" x="', head[i][2], '" y="', head[i][3], '"  fill="#', head[i][4], '"/>'
                )
            );
        }
        for (uint256 i = 0; i < glasses.length; i += 1) {
            chunk = string(
                abi.encodePacked(
                    chunk,
                    '<rect width="', glasses[i][0], '" height="', glasses[i][1], '" x="', glasses[i][2], '" y="', glasses[i][3], '"  fill="#', glasses[i][4], '"/>'
                )
            );
        }

        for (uint256 i = 0; i < accessory.length; i += 1) {
            chunk = string(
                abi.encodePacked(
                    chunk,
                    '<rect width="', accessory[i][0], '" height="', accessory[i][1], '" x="', accessory[i][2], '" y="', accessory[i][3], '"  fill="#', accessory[i][4], '"/>'
                )
            );
        }

        string memory background = "#d5d7e1";
        return string(
            abi.encodePacked(
                '<svg width="320" height="320" viewBox="0 0 320 320" xmlns="http://www.w3.org/2000/svg" shape-rendering="crispEdges">',
                '<rect width="100%" height="100%" fill="', background, '" />',
                chunk,
                '</svg>'
            )
            );
    }




    function create(string memory svg) public {
        _safeMint(msg.sender, tokenCounter);
        string memory imageURI = svgToImageURI(svg);
        _setTokenURI(tokenCounter, formatTokenURI(imageURI));
        tokenCounter = tokenCounter + 1;
        emit CreatedSVGNFT(tokenCounter, svg);
    }
    // You could also just upload the raw SVG and have solildity convert it!
    function svgToImageURI(string memory svg) view public returns (string memory) {
        // example:
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(createRect()))));
        return string(abi.encodePacked(baseURL,svgBase64Encoded));
    }

    function formatTokenURI(string memory imageURI) public pure returns (string memory) {
        return string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                "SVG NFT", // You can add whatever name here
                                '", "description":"An NFT based on SVG!", "attributes":"", "image":"',imageURI,'"}'
                            )
                        )
                    )
                )
            );
    }
}