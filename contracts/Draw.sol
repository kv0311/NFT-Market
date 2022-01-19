pragma solidity ^0.8.2;
contract Test{
    struct RectInfo {
        string width;
        string height;
        string x;
        string y;
        string fill;
    }
    function testSplit(string memory str) public returns (bytes memory ){
        bytes memory a = bytes(str);
        // string[] memory str;
        // for (uint256 i = 0; i < a.length; i += 1) {
        //     str.push("ds");
        // }
        return a;
        // return str;
        // return a[1];
    }
    function createRect() public returns (string memory){
        // '<rect width="10" height="10" x="170" y="120" fill="#d19a54" />''
        RectInfo[] memory rectInfo;
        rectInfo[0] = RectInfo("60","10","100","110","d19a54");
        // rectInfo.push(RectInfo("60","10","100","110","d19a54"));
        // svgInfo[1] = ["60","10","100","110","d19a54"];
        string memory chunk;
        for (uint256 i = 0; i < rectInfo.length; i += 1) {
            chunk = string(
                abi.encodePacked(
                    chunk,
                    '<rect width="', rectInfo[i].width, '" height="', rectInfo[i].height, '" x="', rectInfo[i].x, '" y="', rectInfo[i].y, '"  fill="#', rectInfo[i].fill, '"/>'
                )
            );
        }
        return chunk;
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