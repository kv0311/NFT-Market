// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "base64-sol/base64.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SVGNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    event CreatedSVGNFT(uint256 indexed tokenId, string tokenURI);

    struct NFTInfo {
        string name;
        string description;
        string bgHue;
        string textHue;
        string value;
    }
    mapping(uint256 => NFTInfo) public nftInfoToTokenId;
    constructor() ERC721("SVG NFT", "svgNFT")
    {
        
    }
    // function create(string memory svg) public {
    //     uint256 newItemId = _tokenIds.current();
    //     _safeMint(msg.sender, newItemId);
    //     string memory imageURI = svgToImageURI(svg);
    //     _setTokenURI(newItemId, formatTokenURI(imageURI));
    //     _tokenIds.increment();
    //     emit CreatedSVGNFT(tokenCounter, svg);
    // }
    function mint(string memory _text) public payable {
        if (msg.sender != owner()) {
            require(msg.value >= 0.005 ether);
        }
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        nftInfoToTokenId[newItemId] ;
        _safeMint(msg.sender, newItemId);

    }
    function buildImageURI(string memory svg) public pure returns (string memory) {
        // example:
        // <svg width='500' height='500' viewBox='0 0 285 350' fill='none' xmlns='http://www.w3.org/2000/svg'><path fill='black' d='M150,0,L75,200,L225,200,Z'></path></svg>
        // data:image/svg+xml;base64,PHN2ZyB3aWR0aD0nNTAwJyBoZWlnaHQ9JzUwMCcgdmlld0JveD0nMCAwIDI4NSAzNTAnIGZpbGw9J25vbmUnIHhtbG5zPSdodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2Zyc+PHBhdGggZmlsbD0nYmxhY2snIGQ9J00xNTAsMCxMNzUsMjAwLEwyMjUsMjAwLFonPjwvcGF0aD48L3N2Zz4=
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(baseURL,svgBase64Encoded));
    }

    function buildMetaDataURI(uint256 _tokenId) private view returns (string memory){
        NFTInfo memory nftInfo = nftInfoToTokenId[_tokenId];
        return string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                currentWord.name,
                                '", "description":"',
                                currentWord.description,
                                '", "image": "',
                                "data:image/svg+xml;base64,",
                                buildImage(_tokenId),
                                '", "attributes": ',
                                "[",
                                '{"trait_type": "TextColor",',
                                '"value":"',
                                currentWord.textHue,
                                '"}',
                                "]",
                                "}"
                            )
                        )
                    )
                )
            );
    }

}

