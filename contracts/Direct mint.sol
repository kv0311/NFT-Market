pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "base64-sol/base64.sol";
contract SVGNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;
    // event CreatedSVGNFT(uint256 indexed tokenId, string tokenURI);
    uint256[][][] public body;
    uint256[][][] public head;
    uint256[][][] public accessory;
    uint256[][][] public glasses;
    
    string[] public colors;


    constructor() ERC721("SVG NFT", "svgNFT")
    {
        tokenCounter = 0;
    }
    function create(string memory svg) public {
        _safeMint(msg.sender, tokenCounter);
        string memory imageURI = buildImage();
        _setTokenURI(tokenCounter, buildMetaData(imageURI));
        tokenCounter = tokenCounter + 1;
    }
    function buildImage() view public returns (string memory) {
        // example:
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(createRect()))));
        return string(abi.encodePacked(baseURL,svgBase64Encoded));
    }

    function buildMetaData(string memory imageURI) public view returns (string memory) {
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

    // [[14,9,21,30],[14,9,22,30],[14,9,23,30],[14,9,24,30],[2,9,25,30],[11,12,25,30],[2,9,26,30],[11,12,26,30],[2,9,27,30],[11,12,27,30],[2,9,28,30],[11,12,28,30],[2,9,29,30],[11,12,29,30],[2,9,30,30],[11,12,3,30],[2,9,31,30],[11,12,31,30]]
    // [["140","10","90","210","eed811"],["140","10","90","220","eed811"],["140","10","90","230","eed811"],["140","10","90","240","eed811"],["20","10","90","250","eed811"],["110","10","120","250","eed811"],["20","10","90","260","eed811"],["110","10","120","260","eed811"],["20","10","90","270","eed811"],["110","10","120","270","eed811"],["20","10","90","280","eed811"],["110","10","120","280","eed811"],["20","10","90","290","eed811"],["110","10","120","290","eed811"],["20","10","90","300","eed811"],["110","10","120","300","eed811"],["20","10","90","310","eed811"],["110","10","120","310","eed811"]]
    function addBody( uint256[][] memory _body) public returns (uint256[][] memory){
        body.push(_body);
    }
    // [[3,15,3,79],[1,16,4,79],[6,13,5,79],[10,11,6,79],[14,9,7,67],[10,8,8,67],[1,18,8,6],[1,19,8,67],[2,20,8,6],[2,22,8,67],[12,8,9,67],[2,20,9,6],[2,22,9,67],[18,7,10,67],[18,7,11,67],[18,7,12,67],[20,6,13,67],[20,6,14,67],[20,6,15,67],[20,6,16,79],[24,4,17,79],[5,3,18,79],[2,8,18,109],[1,10,18,79],[2,11,18,109],[1,13,18,79],[2,14,18,109],[1,16,18,79],[2,17,18,109],[1,19,18,79],[2,20,18,109],[1,22,18,79],[2,23,18,109],[4,25,18,79],[6,2,19,79],[2,8,19,109],[1,10,19,79],[2,11,19,109],[1,13,19,79],[2,14,19,109],[1,16,19,79],[2,17,19,109],[1,19,19,79],[2,20,19,109],[1,22,19,79],[2,23,19,109],[5,25,19,79],[20,6,20,79],[10,11,21,79]]
    //[["30","10","150","30","fb4694"],["10","10","160","40","fb4694"],["60","10","130","50","fb4694"],["100","10","110","60","fb4694"],["140","10","90","70","2b83f6"],["100","10","80","80","2b83f6"],["10","10","180","80","caeff9"],["10","10","190","80","2b83f6"],["20","10","200","80","caeff9"],["20","10","220","80","2b83f6"],["120","10","80","90","2b83f6"],["20","10","200","90","caeff9"],["20","10","220","90","2b83f6"],["180","10","70","100","2b83f6"],["180","10","70","110","2b83f6"],["180","10","70","120","2b83f6"],["200","10","60","130","2b83f6"],["200","10","60","140","2b83f6"],["200","10","60","150","2b83f6"],["200","10","60","160","fb4694"],["240","10","40","170","fb4694"],["50","10","30","180","fb4694"],["20","10","80","180","ffe939"],["10","10","100","180","fb4694"],["20","10","110","180","ffe939"],["10","10","130","180","fb4694"],["20","10","140","180","ffe939"],["10","10","160","180","fb4694"],["20","10","170","180","ffe939"],["10","10","190","180","fb4694"],["20","10","200","180","ffe939"],["10","10","220","180","fb4694"],["20","10","230","180","ffe939"],["40","10","250","180","fb4694"],["60","10","20","190","fb4694"],["20","10","80","190","ffe939"],["10","10","100","190","fb4694"],["20","10","110","190","ffe939"],["10","10","130","190","fb4694"],["20","10","140","190","ffe939"],["10","10","160","190","fb4694"],["20","10","170","190","ffe939"],["10","10","190","190","fb4694"],["20","10","200","190","ffe939"],["10","10","220","190","fb4694"],["20","10","230","190","ffe939"],["50","10","250","190","fb4694"],["200","10","60","200","fb4694"],["100","10","110","210","fb4694"]]
    function addHead( uint256[][] memory _head) public returns (uint256[][] memory){
        head.push(_head);
    }

    // [[6,10,11,222],[6,17,11,222],[1,10,12,222],[2,11,12,222],[2,13,12,35],[1,15,12,222],[1,17,12,222],[2,18,12,1],[2,20,12,35],[1,22,12,222],[4,7,13,222 ],[2,11,13,1],[2,13,13,35],[3,15,13,222],[2,18,13,1],[2,20,13,35],[1,22,13,222],[1,7,14,222 ],[1,10,14,222],[2,11,14,1],[2,13,14,35],[1,15,14,222],[1,17,14,222],[2,18,14,1],[2,20,14,35],[1,22,14,222],[1,7,15,222 ],[1,10,15,222],[2,11,15,1],[2,13,15,35],[1,15,15,222],[1,17,15,222],[2,18,15,1],[2,20,15,35],[1,22,15,222],[6,10,16,222],[6,17,16,222]]
    //[["60","10","100","110","d19a54"],["60","10","170","110","d19a54"],["10","10","100","120","d19a54"],["20","10","110","120","d19a54"],["20","10","130","120","000000"],["10","10","150","120","d19a54"],["10","10","170","120","d19a54"],["20","10","180","120","ffffff"],["20","10","200","120","000000"],["10","10","220","120","d19a54"],["40","10","70","130","19a54" ],["20","10","110","130","ffffff"],["20","10","130","130","000000"],["30","10","150","130","d19a54"],["20","10","180","130","ffffff"],["20","10","200","130","000000"],["10","10","220","130","d19a54"],["10","10","70","140","19a54" ],["10","10","100","140","d19a54"],["20","10","110","140","ffffff"],["20","10","130","140","000000"],["10","10","150","140","d19a54"],["10","10","170","140","d19a54"],["20","10","180","140","ffffff"],["20","10","200","140","000000"],["10","10","220","140","d19a54"],["10","10","70","150","19a54" ],["10","10","100","150","d19a54"],["20","10","110","150","ffffff"],["20","10","130","150","000000"],["10","10","150","150","d19a54"],["10","10","170","150","d19a54"],["20","10","180","150","ffffff"],["20","10","200","150","000000"],["10","10","220","150","d19a54"],["60","10","100","160","d19a54"],["60","10","170","160","d19a54"]]
    function addGlasses( uint256[][] memory _glasses) public returns (uint256[][] memory){
        glasses.push(_glasses);
    }

    // [[7,13,24,86],[1,13,25,86],[1,15,25,86],[1,17,25,86],[3,19,25,86],[3,13,26,86],[3,17,26,86],[1,21,26,86]]
    // [["70","10","130","240","26b1f3"],["10","10","130","250","26b1f3"],["10","10","150","250","26b1f3"],["10","10","170","250","26b1f3"],["30","10","190","250","26b1f3"],["30","10","130","260","26b1f3"],["30","10","170","260","26b1f3"],["10","10","210","260","26b1f3"]]
    function addAccessory( uint256[][] memory _accessory) public returns (uint256[][] memory){
        accessory.push(_accessory);
    }
    
    function addColors(string[] memory _colors) public {
        colors = _colors;
    }
    function createRect() public view returns (string memory){   
        string[33] memory lookup = [
            '0', '10', '20', '30', '40', '50', '60', '70', 
            '80', '90', '100', '110', '120', '130', '140', '150',  
            '160', '170', '180', '190', '200', '210', '220', '230', 
            '240', '250', '260', '270', '280', '290', '300', '310',
            '320' 
        ];
        string memory chunk;
        
        uint256[][] memory rectBody = body[0];
        uint256[][] memory rectHead = head[0];
        uint256[][] memory rectAccessory = accessory[0];
        uint256[][] memory rectGlasses = glasses[0];
        
        uint256 cursor;
        string[16] memory buffer;
        string memory part;

        for (uint256 i = 0; i < rectBody.length; i += 1) {
            buffer[cursor] = lookup[rectBody[i][0]];          // width
            buffer[cursor + 1] = lookup[rectBody[i][1]];        // x
            buffer[cursor + 2] = lookup[rectBody[i][2]];         // y
            buffer[cursor + 3] = colors[rectBody[i][3]];   
            cursor+=4;
            if (cursor >= 16) {
                part = string(abi.encodePacked(part, _getChunk(cursor, buffer)));
                cursor = 0;
            }
        }

        for (uint256 i = 0; i < rectHead.length; i += 1) {
            buffer[cursor] = lookup[rectHead[i][0]];          // width
            buffer[cursor + 1] = lookup[rectHead[i][1]];        // x
            buffer[cursor + 2] = lookup[rectHead[i][2]];         // y
            buffer[cursor + 3] = colors[rectHead[i][3]];   
            cursor+=4;
            if (cursor >= 16) {
                part = string(abi.encodePacked(part, _getChunk(cursor, buffer)));
                cursor = 0;
            }
        }
        for (uint256 i = 0; i < rectAccessory.length; i += 1) {
            buffer[cursor] = lookup[rectAccessory[i][0]];          // width
            buffer[cursor + 1] = lookup[rectAccessory[i][1]];        // x
            buffer[cursor + 2] = lookup[rectAccessory[i][2]];         // y
            buffer[cursor + 3] = colors[rectAccessory[i][3]];   
            cursor+=4;
            if (cursor >= 16) {
                part = string(abi.encodePacked(part, _getChunk(cursor, buffer)));
                cursor = 0;
            }
        }
        for (uint256 i = 0; i < rectGlasses.length; i += 1) {
            buffer[cursor] = lookup[rectGlasses[i][0]];          // width
            buffer[cursor + 1] = lookup[rectGlasses[i][1]];        // x
            buffer[cursor + 2] = lookup[rectGlasses[i][2]];         // y
            buffer[cursor + 3] = colors[rectGlasses[i][3]];   
            cursor+=4;
            if (cursor >= 16) {
                part = string(abi.encodePacked(part, _getChunk(cursor, buffer)));
                cursor = 0;
            }
        }
        string memory background = "#d5d7e1";
        return string(
            abi.encodePacked(
                '<svg width="320" height="320" viewBox="0 0 320 320" xmlns="http://www.w3.org/2000/svg" shape-rendering="crispEdges">',
                '<rect width="100%" height="100%" fill="', background, '" />',
                part, 
                '</svg>'
            )
            );
    }

   function _getChunk(uint256 cursor, string[16] memory buffer) private pure returns (string memory) {
        string memory chunk;
        for (uint256 i = 0; i < cursor; i += 4) {
            chunk = string(
                abi.encodePacked(
                    chunk,
                    '<rect width="', buffer[i], '" height="10" x="', buffer[i + 1], '" y="', buffer[i + 2], '" fill="#', buffer[i + 3], '" />'
                )
            );
        }
        return chunk;
    }
}