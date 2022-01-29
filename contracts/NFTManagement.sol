// pragma solidity ^0.8.6;
// import { Ownable } from '@openzeppelin/contracts/access/Ownable.sol';
// import { IERC721 } from '@openzeppelin/contracts/token/ERC721/IERC721.sol';
// import { ERC721Checkpointable } from './base/ERC721Checkpointable.sol';
// import { ERC721 } from './base/ERC721.sol';

import { INounsDescriptor } from './interfaces/INounsDescriptor.sol';
import { INounsSeeder } from './interfaces/INounsSeeder.sol';

// import './Descriptor.sol';
// import
import { NFTUtils } from './NFTUtils.sol';

// contract NFTManagement is Ownable, ERC721Checkpointable {
//     // The Nouns token URI descriptor
    
    INounsDescriptor private descriptor;
    address public minter;
    address public founder;
    uint256 private _currentNounId;

    INounsSeeder public seeder;

    mapping(uint256 => INounsSeeder.Seed) public seeds;

    constructor(
        address _minter,
        INounsDescriptor _descriptor,
        INounsSeeder _seeder
    ) ERC721("NFT", "svgNFT")
    {
        minter = _minter;
        descriptor = _descriptor;
        seeder = _seeder;
    }
    function setMinter() public onlyOwner {
        minter = msg.sender;
    }
    function setFounder(address _founder) public onlyOwner {
        founder = _founder;
    }

    /* Minting */
    function mint() public onlyOwner returns (uint256) {
        if (_currentNounId <= 1820 && _currentNounId % 10 == 0) {
            _mintTo(founder, _currentNounId++);
        }
        return _mintTo(minter, _currentNounId++);
    }
    function _mintTo(address to, uint256 nounId) internal returns (uint256) {
        seeds[nounId] = NFTUtils.generateSeed(nounId, descriptor);

//         _mint(owner(), to, nounId);
//         // emit NounCreated(nounId, seed);
//         return nounId;
//     }
//     /* Get SVG */
//     function tokenURI(uint256 tokenId) public view override returns (string memory) {
//         require(_exists(tokenId), 'NounsToken: URI query for nonexistent token');
//         return descriptor.tokenURI(tokenId, seeds[tokenId]);
//     }
// }