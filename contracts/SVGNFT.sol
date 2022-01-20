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

    struct RectIndex {
        uint256 body;
        uint256 head;
        uint256 accessory;
        uint256 glasses;
        // uint256 color;
    }



    string[][][] public body;
    string[][][] public head;
    string[][][] public accessory;
    string[][][] public glasses;

    RectInfo[] public rectInfoList;
    constructor() ERC721("SVG NFT", "svgNFT")
    {
        tokenCounter = 0;
    }
    // [["140","10","90","210","eed811"],["140","10","90","220","eed811"],["140","10","90","230","eed811"],["140","10","90","240","eed811"],["20","10","90","250","eed811"],["110","10","120","250","eed811"],["20","10","90","260","eed811"],["110","10","120","260","eed811"],["20","10","90","270","eed811"],["110","10","120","270","eed811"],["20","10","90","280","eed811"],["110","10","120","280","eed811"],["20","10","90","290","eed811"],["110","10","120","290","eed811"],["20","10","90","300","eed811"],["110","10","120","300","eed811"],["20","10","90","310","eed811"],["110","10","120","310","eed811"]]
    function addBody( string[][] memory _body) public returns (string[][] memory){
        body.push(_body);
    }

    //[["30","10","150","30","fb4694"],["10","10","160","40","fb4694"],["60","10","130","50","fb4694"],["100","10","110","60","fb4694"],["140","10","90","70","2b83f6"],["100","10","80","80","2b83f6"],["10","10","180","80","caeff9"],["10","10","190","80","2b83f6"],["20","10","200","80","caeff9"],["20","10","220","80","2b83f6"],["120","10","80","90","2b83f6"],["20","10","200","90","caeff9"],["20","10","220","90","2b83f6"],["180","10","70","100","2b83f6"],["180","10","70","110","2b83f6"],["180","10","70","120","2b83f6"],["200","10","60","130","2b83f6"],["200","10","60","140","2b83f6"],["200","10","60","150","2b83f6"],["200","10","60","160","fb4694"],["240","10","40","170","fb4694"],["50","10","30","180","fb4694"],["20","10","80","180","ffe939"],["10","10","100","180","fb4694"],["20","10","110","180","ffe939"],["10","10","130","180","fb4694"],["20","10","140","180","ffe939"],["10","10","160","180","fb4694"],["20","10","170","180","ffe939"],["10","10","190","180","fb4694"],["20","10","200","180","ffe939"],["10","10","220","180","fb4694"],["20","10","230","180","ffe939"],["40","10","250","180","fb4694"],["60","10","20","190","fb4694"],["20","10","80","190","ffe939"],["10","10","100","190","fb4694"],["20","10","110","190","ffe939"],["10","10","130","190","fb4694"],["20","10","140","190","ffe939"],["10","10","160","190","fb4694"],["20","10","170","190","ffe939"],["10","10","190","190","fb4694"],["20","10","200","190","ffe939"],["10","10","220","190","fb4694"],["20","10","230","190","ffe939"],["50","10","250","190","fb4694"],["200","10","60","200","fb4694"],["100","10","110","210","fb4694"]]
    function addHead( string[][] memory _head) public returns (string[][] memory){
        head.push( _head);
    }

    //[["60","10","100","110","d19a54"],["60","10","170","110","d19a54"],["10","10","100","120","d19a54"],["20","10","110","120","d19a54"],["20","10","130","120","000000"],["10","10","150","120","d19a54"],["10","10","170","120","d19a54"],["20","10","180","120","ffffff"],["20","10","200","120","000000"],["10","10","220","120","d19a54"],["40","10","70","130","19a54" ],["20","10","110","130","ffffff"],["20","10","130","130","000000"],["30","10","150","130","d19a54"],["20","10","180","130","ffffff"],["20","10","200","130","000000"],["10","10","220","130","d19a54"],["10","10","70","140","19a54" ],["10","10","100","140","d19a54"],["20","10","110","140","ffffff"],["20","10","130","140","000000"],["10","10","150","140","d19a54"],["10","10","170","140","d19a54"],["20","10","180","140","ffffff"],["20","10","200","140","000000"],["10","10","220","140","d19a54"],["10","10","70","150","19a54" ],["10","10","100","150","d19a54"],["20","10","110","150","ffffff"],["20","10","130","150","000000"],["10","10","150","150","d19a54"],["10","10","170","150","d19a54"],["20","10","180","150","ffffff"],["20","10","200","150","000000"],["10","10","220","150","d19a54"],["60","10","100","160","d19a54"],["60","10","170","160","d19a54"]]
    function addGlasses( string[][] memory _glasses) public returns (string[][] memory){
        glasses.push(_glasses);
    }
// [["70","10","130","240","26b1f3"],["10","10","130","250","26b1f3"],["10","10","150","250","26b1f3"],["10","10","170","250","26b1f3"],["30","10","190","250","26b1f3"],["30","10","130","260","26b1f3"],["30","10","170","260","26b1f3"],["10","10","210","260","26b1f3"]]
    function addAccessory( string[][] memory _accessory) public returns (string[][] memory){
        accessory.push(_accessory);
    }
    
    function createRect(uint256 _tokenId) public view returns (string memory){
        // uint256 pseudorandomness = uint256(
        //     keccak256(abi.encodePacked(blockhash(block.number - 1), _tokenId))
        // );
        // RectIndex memory rectIndex = RectIndex(
        //     body.length % pseudorandomness,
        //     head.length % pseudorandomness,
        //     glasses.length % pseudorandomness,
        //     accessory.length % pseudorandomness
        // );

        string memory chunk;
        string[][] memory bodyData = body[0];
        string[][] memory headData = head[0];
        string[][] memory glassesData = glasses[0];
        string[][] memory accessoryData = accessory[0];

        for (uint256 i = 0; i < bodyData.length; i += 1) {
            chunk = string(
                abi.encodePacked(
                    chunk,
                    '<rect width="', bodyData[i][0], '" height="', bodyData[i][1], '" x="', bodyData[i][2], '" y="', bodyData[i][3], '"  fill="#', bodyData[i][4], '"/>'
                )
            );
        }

        for (uint256 i = 0; i < headData.length; i += 1) {
            chunk = string(
                abi.encodePacked(
                    chunk,
                    '<rect width="', headData[i][0], '" height="', headData[i][1], '" x="', headData[i][2], '" y="', headData[i][3], '"  fill="#', headData[i][4], '"/>'
                )
            );
        }
        for (uint256 i = 0; i < glassesData.length; i += 1) {
            chunk = string(
                abi.encodePacked(
                    chunk,
                    '<rect width="', glassesData[i][0], '" height="', glassesData[i][1], '" x="', glassesData[i][2], '" y="', glassesData[i][3], '"  fill="#', glassesData[i][4], '"/>'
                )
            );
        }

        for (uint256 i = 0; i < accessoryData.length; i += 1) {
            chunk = string(
                abi.encodePacked(
                    chunk,
                    '<rect width="', accessoryData[i][0], '" height="', accessoryData[i][1], '" x="', accessoryData[i][2], '" y="', accessoryData[i][3], '"  fill="#', accessoryData[i][4], '"/>'
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




    function mint() public payable {
        _safeMint(msg.sender, tokenCounter);
        // _setTokenURI(tokenCounter, formatTokenURI(imageURI));
        tokenCounter = tokenCounter + 1;
        // emit CreatedSVGNFT(tokenCounter, svg);
    }
    // You could also just upload the raw SVG and have solildity convert it!
    function buildImage(uint256 _tokenId) view public returns (string memory) {
        // example:
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(createRect(_tokenId)))));
        return string(abi.encodePacked(baseURL,svgBase64Encoded));
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(_tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );
        return buildMetadata(_tokenId);
    }

    function buildMetadata(uint256 _tokenId) public view returns (string memory) {
        string memory imageURI = buildImage(_tokenId);
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

[["7","1","13","24","26b1f3"],["1","1","13","25","26b1f3"],["1","1","15","25","26b1f3"],["1","1","17","25","26b1f3"],["3","1","19","25","26b1f3"],["3","1","13","26","26b1f3"],["3","1","17","26","26b1f3"],["1","1","21","26","26b1f3"]]
[["14","1","9","21","eed811"],["14","1","9","22","eed811"],["14","1","9","23","eed811"],["14","1","9","24","eed811"],["2","1","9","25","eed811"],["11","1","12","25","eed811"],["2","1","9","26","eed811"],["11","1","12","26","eed811"],["2","1","9","27","eed811"],["11","1","12","27","eed811"],["2","1","9","28","eed811"],["11","1","12","28","eed811"],["2","1","9","29","eed811"],["11","1","12","29","eed811"],["2","1","9","3","eed811"],["11","1","12","3","eed811"],["2","1","9","31","eed811"],["11","1","12","31","eed811"]]
[["6","1","1","11","d19a54"],["6","1","17","11","d19a54"],["1","1","1","12","d19a54"],["2","1","11","12","d19a54"],["2","1","13","12",""],["1","1","15","12","d19a54"],["1","1","17","12","d19a54"],["2","1","18","12","ffffff"],["2","1","2","12",""],["1","1","22","12","d19a54"],["4","1","7","13","19a54" ],["2","1","11","13","ffffff"],["2","1","13","13",""],["3","1","15","13","d19a54"],["2","1","18","13","ffffff"],["2","1","2","13",""],["1","1","22","13","d19a54"],["1","1","7","14","19a54" ],["1","1","1","14","d19a54"],["2","1","11","14","ffffff"],["2","1","13","14",""],["1","1","15","14","d19a54"],["1","1","17","14","d19a54"],["2","1","18","14","ffffff"],["2","1","2","14",""],["1","1","22","14","d19a54"],["1","1","7","15","19a54" ],["1","1","1","15","d19a54"],["2","1","11","15","ffffff"],["2","1","13","15",""],["1","1","15","15","d19a54"],["1","1","17","15","d19a54"],["2","1","18","15","ffffff"],["2","1","2","15",""],["1","1","22","15","d19a54"],["6","1","1","16","d19a54"],["6","1","17","16","d19a54"]]
[["3","1","15","3","fb4694"],["1","1","16","4","fb4694"],["6","1","13","5","fb4694"],["1","1","11","6","fb4694"],["14","1","9","7","2b83f6"],["1","1","8","8","2b83f6"],["1","1","18","8","caeff9"],["1","1","19","8","2b83f6"],["2","1","2","8","caeff9"],["2","1","22","8","2b83f6"],["12","1","8","9","2b83f6"],["2","1","2","9","caeff9"],["2","1","22","9","2b83f6"],["18","1","7","1","2b83f6"],["18","1","7","11","2b83f6"],["18","1","7","12","2b83f6"],["2","1","6","13","2b83f6"],["2","1","6","14","2b83f6"],["2","1","6","15","2b83f6"],["2","1","6","16","fb4694"],["24","1","4","17","fb4694"],["5","1","3","18","fb4694"],["2","1","8","18","ffe939"],["1","1","1","18","fb4694"],["2","1","11","18","ffe939"],["1","1","13","18","fb4694"],["2","1","14","18","ffe939"],["1","1","16","18","fb4694"],["2","1","17","18","ffe939"],["1","1","19","18","fb4694"],["2","1","2","18","ffe939"],["1","1","22","18","fb4694"],["2","1","23","18","ffe939"],["4","1","25","18","fb4694"],["6","1","2","19","fb4694"],["2","1","8","19","ffe939"],["1","1","1","19","fb4694"],["2","1","11","19","ffe939"],["1","1","13","19","fb4694"],["2","1","14","19","ffe939"],["1","1","16","19","fb4694"],["2","1","17","19","ffe939"],["1","1","19","19","fb4694"],["2","1","2","19","ffe939"],["1","1","22","19","fb4694"],["2","1","23","19","ffe939"],["5","1","25","19","fb4694"],["2","1","6","2","fb4694"],["1","1","11","21","fb4694"]]