pragma solidity ^0.8.2;

library DrawSVG {
    function _drawSVG (uint256[][] memory rectBody, uint256[][] memory rectHead, uint256[][] memory rectAccessory, uint256[][] memory rectGlasses,string[] memory colors ) internal returns (string memory){
        string[33] memory lookup = [
            '0', '10', '20', '30', '40', '50', '60', '70', 
            '80', '90', '100', '110', '120', '130', '140', '150',  
            '160', '170', '180', '190', '200', '210', '220', '230', 
            '240', '250', '260', '270', '280', '290', '300', '310',
            '320' 
        ];
        string memory chunk;
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