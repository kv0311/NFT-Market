pragma solidity ^0.8.2;
import { Base64 } from 'base64-sol/base64.sol';
import { MultiPartRLEToSVG } from './MultiPartRLEToSVG.sol';

contract OnchainNFT {
    struct Seed {
        uint48 background;
        uint48 body;
        uint48 accessory;
        uint48 head;
        uint48 glasses;
    }
    Seed public seed = Seed(1,20,95,88,14);
    mapping(uint8 => string[]) public palettes;
    constructor(){
    
    }
    function addManyColorsToPalette(uint8 paletteIndex, string[] calldata newColors) public {
        require(palettes[paletteIndex].length + newColors.length <= 256, 'Palettes can only hold 256 colors');
        for (uint256 i = 0; i < newColors.length; i++) {
            _addColorToPalette(paletteIndex, newColors[i]);
        }
    }
    function _addColorToPalette(uint8 _paletteIndex, string calldata _color) internal {
        palettes[_paletteIndex].push(_color);
    }
    function generateSVGImage() external view returns (string memory) {
        MultiPartRLEToSVG.SVGParams memory params = MultiPartRLEToSVG.SVGParams({
            parts: _getPartsForSeed(seed),
            background: "d5d7e1"
        });
        return Base64.encode(bytes(MultiPartRLEToSVG.generateSVG(params, palettes)));
    }
    function _getPartsForSeed(Seed memory seed) internal view returns (bytes[] memory) {
        bytes[] memory _parts = new bytes[](4);
        _parts[0] = '0x0015171f090e020e020e020e02020201000b02020201000b02020201000b02020201000b02020201000b02020201000b02020201000b02';
        _parts[1] = '0x0017141e0d0100011f0500021f05000100011f0300011f01000100011f0200011f02000300011f03000200011f0200021f0100011f0200011f0100011f0400011f0100011f';
        _parts[2] = '0x00021e140605000137020001370f0004000237020002370e0003000337020003370d0002000437020004370c0003000337020003370d0004000237020002370e0005000137020001370f000d370b000d370b000d370b000d370b000d370b000d370b000d370600057d0d370600017d017e017d017e017d0b37097d017e017d017e017d0b370d7d0a370523097d0b370d7d';
        _parts[3] = '0x000b1710070300062001000620030001200201022301200100012002010223012004200201022303200201022301200420020102230320020102230120012002000120020102230120010001200201022301200300062001000620';
        return _parts;
    }
}
