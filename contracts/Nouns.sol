pragma solidity >=0.8.0 <0.9.0;
import { Base64 } from 'base64-sol/base64.sol';
import { MultiPartRLEToSVG } from './MultiPartRLEToSVG.sol';
import { images, bgcolors } from './image.json';

const { bodies, accessories, heads, glasses } = images;
contract OnchainNFT {
    struct Seed {
        uint48 background;
        uint48 body;
        uint48 accessory;
        uint48 head;
        uint48 glasses;
    }
    mapping(uint8 => string[]) public palettes;
    constructor(){
    palettes[0]= ["FFFFFF"];
    
    }
    function _getPartsForSeed(Seed memory seed) internal view returns (bytes[] memory) {
        bytes[] memory _parts = new bytes[](4);
        _parts[0] = bodies[seed.body];
        _parts[1] = accessories[seed.accessory];
        _parts[2] = heads[seed.head];
        _parts[3] = glasses[seed.glasses];
        return _parts;
    }
}
