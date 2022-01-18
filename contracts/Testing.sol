pragma solidity ^0.8.2;
import "hardhat/console.sol";
import { Base64 } from 'base64-sol/base64.sol';
contract Testing {
    struct SVGParams {
        bytes[] parts;
        string background;
    }

    struct ContentBounds {
        uint8 top;
        uint8 right;
        uint8 bottom;
        uint8 left;
    }

    struct Rect {
        uint8 length;
        uint8 colorIndex;
    }

    struct DecodedImage {
        uint8 paletteIndex;
        ContentBounds bounds;
        Rect[] rects;
    }
    constructor(){
        
    }
function generateSVG(string[] memory palettes)
        public
        returns (string memory svg)
    {
        // prettier-ignore
        return string(
            abi.encodePacked(
                '<svg width="320" height="320" viewBox="0 0 320 320" xmlns="http://www.w3.org/2000/svg" shape-rendering="crispEdges">',
                '<rect width="100%" height="100%" fill="#', "d5d7e1", '" />',
                generateSVGRects( palettes),
                '</svg>'
            )
        );
    }

function generateSVGRects(string[] memory palettes)
        public
        returns (string memory svg)
    {
        bytes[] memory parts = new bytes[](4);
        parts[0] = '0x0015171f090e020e020e020e02020201000b02020201000b02020201000b02020201000b02020201000b02020201000b02020201000b02';
        parts[1] = '0x0017141e0d0100011f0500021f05000100011f0300011f01000100011f0200011f02000300011f03000200011f0200021f0100011f0200011f0100011f0400011f0100011f';
        parts[2] = '0x00021e140605000137020001370f0004000237020002370e0003000337020003370d0002000437020004370c0003000337020003370d0004000237020002370e0005000137020001370f000d370b000d370b000d370b000d370b000d370b000d370b000d370600057d0d370600017d017e017d017e017d0b37097d017e017d017e017d0b370d7d0a370523097d0b370d7d';
        parts[3] = '0x000b1710070300062001000620030001200201022301200100012002010223012004200201022303200201022301200420020102230320020102230120012002000120020102230120010001200201022301200300062001000620';
        string[33] memory lookup = [
            '0', '10', '20', '30', '40', '50', '60', '70', 
            '80', '90', '100', '110', '120', '130', '140', '150', 
            '160', '170', '180', '190', '200', '210', '220', '230', 
            '240', '250', '260', '270', '280', '290', '300', '310',
            '320' 
        ];
        string memory rects;
        // for (uint8 p = 0; p < parts.length; p++) {
            DecodedImage memory image = _decodeRLEImage(parts[0]);
            string[] memory palette = palettes;
            uint256 currentX = image.bounds.left;
            uint256 currentY = image.bounds.top;
            uint256 cursor;
            string[16] memory buffer;

            string memory part;
            console.log(image.rects.length);
            // for (uint256 i = 0; i < image.rects.length; i++) {
            //     Rect memory rect = image.rects[i];
            //     if (rect.colorIndex != 0) {
            //         buffer[cursor] = lookup[rect.length];          // width
            //         buffer[cursor + 1] = lookup[currentX];         // x
            //         buffer[cursor + 2] = lookup[currentY];         // y
            //         buffer[cursor + 3] = palette[rect.colorIndex]; // color

            //         cursor += 4;

            //         if (cursor >= 16) {
            //             part = string(abi.encodePacked(part, _getChunk(cursor, buffer)));
            //             cursor = 0;
            //         }
            //     }

            //     currentX += rect.length;
            //     if (currentX == image.bounds.right) {
            //         currentX = image.bounds.left;
            //         currentY++;
            //     }
            // }

            if (cursor != 0) {
                part = string(abi.encodePacked(part, _getChunk(cursor, buffer)));
            }
            rects = string(abi.encodePacked(rects, part));
        // }
        return Base64.encode(bytes(rects));
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
    function _decodeRLEImage(bytes memory image) public returns (DecodedImage memory ) {
        uint8 paletteIndex = uint8(image[0]);
        // return paletteIndex;
        ContentBounds memory bounds = ContentBounds({
            top: uint8(image[1]),
            right: uint8(image[2]),
            bottom: uint8(image[3]),
            left: uint8(image[4])
        });
        // return bounds;
        uint256 cursor;
        Rect[] memory rects = new Rect[]((7 - 5) / 2);
        for (uint256 i = 5; i < 6; i += 2) {
            rects[cursor] = Rect({ length: uint8(image[i]), colorIndex: uint8(image[i + 1]) });
            cursor++;
        }
        return DecodedImage({ paletteIndex: paletteIndex, bounds: bounds, rects: rects });
    }
}