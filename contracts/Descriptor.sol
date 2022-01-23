pragma solidity ^0.8.2;
import { Strings } from '@openzeppelin/contracts/utils/Strings.sol';
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "base64-sol/base64.sol";
import "./DrawSVG.sol";
contract Descriptor is ERC721URIStorage, Ownable {
    struct Seed {
        uint48 body;
        uint48 accessory;
        uint48 head;
        uint48 glasses;
    }

    string public override baseURI;

    // Noun Color Palettes (Index => Hex Colors)
    mapping(uint8 => string[]) public override palettes;

    // Noun Backgrounds (Hex Colors)
    string[] public override backgrounds;

    // Noun Bodies (Custom RLE)
    bytes[] public override bodies;

    // Noun Accessories (Custom RLE)
    bytes[] public override accessories;

    // Noun Heads (Custom RLE)
    bytes[] public override heads;

    // Noun Glasses (Custom RLE)
    bytes[] public override glasses;

    /**
     * @notice Require that the parts have not been locked.
     */
    modifier whenPartsNotLocked() {
        require(!arePartsLocked, 'Parts are locked');
        _;
    }

    /**
     * @notice Get the number of available Noun `backgrounds`.
     */
    function backgroundCount() external view override returns (uint256) {
        return backgrounds.length;
    }

    /**
     * @notice Get the number of available Noun `bodies`.
     */
    function bodyCount() external view override returns (uint256) {
        return bodies.length;
    }

    /**
     * @notice Get the number of available Noun `accessories`.
     */
    function accessoryCount() external view override returns (uint256) {
        return accessories.length;
    }

    /**
     * @notice Get the number of available Noun `heads`.
     */
    function headCount() external view override returns (uint256) {
        return heads.length;
    }

    /**
     * @notice Get the number of available Noun `glasses`.
     */
    function glassesCount() external view override returns (uint256) {
        return glasses.length;
    }

    /**
     * @notice Add colors to a color palette.
     * @dev This function can only be called by the owner.
     */
    function addManyColorsToPalette(uint8 paletteIndex, string[] calldata newColors) external override onlyOwner {
        require(palettes[paletteIndex].length + newColors.length <= 256, 'Palettes can only hold 256 colors');
        for (uint256 i = 0; i < newColors.length; i++) {
            _addColorToPalette(paletteIndex, newColors[i]);
        }
    }

    /**
     * @notice Batch add Noun backgrounds.
     * @dev This function can only be called by the owner when not locked.
     */
    function addManyBackgrounds(string[] calldata _backgrounds) external override onlyOwner whenPartsNotLocked {
        for (uint256 i = 0; i < _backgrounds.length; i++) {
            _addBackground(_backgrounds[i]);
        }
    }

    /**
     * @notice Batch add Noun bodies.
     * @dev This function can only be called by the owner when not locked.
     */
    function addManyBodies(bytes[] calldata _bodies) external override onlyOwner whenPartsNotLocked {
        for (uint256 i = 0; i < _bodies.length; i++) {
            _addBody(_bodies[i]);
        }
    }

    /**
     * @notice Batch add Noun accessories.
     * @dev This function can only be called by the owner when not locked.
     */
    function addManyAccessories(bytes[] calldata _accessories) external override onlyOwner whenPartsNotLocked {
        for (uint256 i = 0; i < _accessories.length; i++) {
            _addAccessory(_accessories[i]);
        }
    }

    /**
     * @notice Batch add Noun heads.
     * @dev This function can only be called by the owner when not locked.
     */
    function addManyHeads(bytes[] calldata _heads) external override onlyOwner whenPartsNotLocked {
        for (uint256 i = 0; i < _heads.length; i++) {
            _addHead(_heads[i]);
        }
    }

    /**
     * @notice Batch add Noun glasses.
     * @dev This function can only be called by the owner when not locked.
     */
    function addManyGlasses(bytes[] calldata _glasses) external override onlyOwner whenPartsNotLocked {
        for (uint256 i = 0; i < _glasses.length; i++) {
            _addGlasses(_glasses[i]);
        }
    }

    /**
     * @notice Add a single color to a color palette.
     * @dev This function can only be called by the owner.
     */
    function addColorToPalette(uint8 _paletteIndex, string calldata _color) external override onlyOwner {
        require(palettes[_paletteIndex].length <= 255, 'Palettes can only hold 256 colors');
        _addColorToPalette(_paletteIndex, _color);
    }

    /**
     * @notice Add a Noun background.
     * @dev This function can only be called by the owner when not locked.
     */
    function addBackground(string calldata _background) external override onlyOwner whenPartsNotLocked {
        _addBackground(_background);
    }

    /**
     * @notice Add a Noun body.
     * @dev This function can only be called by the owner when not locked.
     */
    function addBody(bytes calldata _body) external override onlyOwner whenPartsNotLocked {
        _addBody(_body);
    }

    /**
     * @notice Add a Noun accessory.
     * @dev This function can only be called by the owner when not locked.
     */
    function addAccessory(bytes calldata _accessory) external override onlyOwner whenPartsNotLocked {
        _addAccessory(_accessory);
    }

    /**
     * @notice Add a Noun head.
     * @dev This function can only be called by the owner when not locked.
     */
    function addHead(bytes calldata _head) external override onlyOwner whenPartsNotLocked {
        _addHead(_head);
    }

    /**
     * @notice Add Noun glasses.
     * @dev This function can only be called by the owner when not locked.
     */
    function addGlasses(bytes calldata _glasses) external override onlyOwner whenPartsNotLocked {
        _addGlasses(_glasses);
    }

    constructor() ERC721("SVG NFT", "svgNFT")
    {
        tokenCounter = 0;
    }
    
    function create(string memory svgText) public {
        uint256 pseudorandomness = DrawSVG.randomIndex(svgText);
        
        seedByToken[tokenCounter] = Seed({
            body: uint48(
                uint48(pseudorandomness >> 48) % body.length
            ),
            accessory: uint48(
                uint48(pseudorandomness >> 96) % accessory.length
            ),
            head: uint48(
                uint48(pseudorandomness >> 144) % head.length
            ),
            glasses: uint48(
                uint48(pseudorandomness >> 192) % glasses.length
            )
        });
        tokenCounter = tokenCounter + 1;
        _safeMint(msg.sender, tokenCounter);

        // string memory imageURI = buildImage();
        // _setTokenURI(tokenCounter, buildMetaData(imageURI));
    }
    function buildImage(uint256  _tokenId) view public returns (string memory) {
        // example:
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(createRect(_tokenId)))));
        return string(abi.encodePacked(baseURL,svgBase64Encoded));
    }
    function buildMetaData(uint256 _tokenId) public view returns (string memory) {
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
    
    function addBodies( uint256[][][] memory _bodies) public onlyOwner{
        for (uint256 i = 0; i < _bodies.length; i += 1) {
            body.push(_bodies[i]);
        }
    }
    // [[4,9,2,88],[1,9,3,88],[2,10,3,98],[1,12,3,88],[4,9,4,88],[10,15,4,39],[1,8,5,97],[1,9,5,88],[1,10,5,98],[2,11,5,88],[2,13,5,97],[1,15,5,39],[8,16,5,67],[1,24,5,39],[1,25,5,97],[1,8,6,97],[4,9,6,88],[2,13,6,97],[1,15,6,39],[1,16,6,67],[6,17,6,84],[1,23,6,67],[1,24,6,39],[1,25,6,97],[1,8,7,97],[1,9,7,111],[2,10,7,98],[1,12,7,111],[2,13,7,97],[1,15,7,39],[8,16,7,67],[1,24,7,39],[1,25,7,97],[1,8,8,97],[4,9,8,111],[2,13,8,97],[1,15,8,39],[1,16,8,67],[3,17,8,84],[4,20,8,67],[1,24,8,39],[1,25,8,97],[1,8,9,97],[4,9,9,39],[2,13,9,97],[1,15,9,39],[8,16,9,67],[1,24,9,39],[1,25,9,97],[18,8,10,97],[18,8,11,97],[18,8,12,97],[18,8,13,97],[18,8,14,97],[18,8,15,97],[18,8,16,97],[15,8,17,97],[2,23,17,42],[1,25,17,97],[1,8,18,97],[2,9,18,135],[1,11,18,97],[2,12,18,135],[1,14,18,97],[2,15,18,135],[1,17,18,97],[2,18,18,135],[1,20,18,97],[4,21,18,42],[1,25,18,97],[1,8,19,97],[2,9,19,135],[1,11,19,97],[2,12,19,135],[1,14,19,97],[2,15,19,135],[1,17,19,97],[2,18,19,135],[1,20,19,97],[4,21,19,42],[1,25,19,97],[18,8,20,97]],
    // [[[3,15,3,79],[1,16,4,79],[6,13,5,79],[10,11,6,79],[14,9,7,67],[10,8,8,67],[1,18,8,6],[1,19,8,67],[2,20,8,6],[2,22,8,67],[12,8,9,67],[2,20,9,6],[2,22,9,67],[18,7,10,67],[18,7,11,67],[18,7,12,67],[20,6,13,67],[20,6,14,67],[20,6,15,67],[20,6,16,79],[24,4,17,79],[5,3,18,79],[2,8,18,109],[1,10,18,79],[2,11,18,109],[1,13,18,79],[2,14,18,109],[1,16,18,79],[2,17,18,109],[1,19,18,79],[2,20,18,109],[1,22,18,79],[2,23,18,109],[4,25,18,79],[6,2,19,79],[2,8,19,109],[1,10,19,79],[2,11,19,109],[1,13,19,79],[2,14,19,109],[1,16,19,79],[2,17,19,109],[1,19,19,79],[2,20,19,109],[1,22,19,79],[2,23,19,109],[5,25,19,79],[20,6,20,79],[10,11,21,79],[1,16,2,79]],
    // [[4,9,2,88],[1,9,3,88],[2,10,3,98],[1,12,3,88],[4,9,4,88],[10,15,4,39],[1,8,5,97],[1,9,5,88],[1,10,5,98],[2,11,5,88],[2,13,5,97],[1,15,5,39],[8,16,5,67],[1,24,5,39],[1,25,5,97],[1,8,6,97],[4,9,6,88],[2,13,6,97],[1,15,6,39],[1,16,6,67],[6,17,6,84],[1,23,6,67],[1,24,6,39],[1,25,6,97],[1,8,7,97],[1,9,7,111],[2,10,7,98],[1,12,7,111],[2,13,7,97],[1,15,7,39],[8,16,7,67],[1,24,7,39],[1,25,7,97],[1,8,8,97],[4,9,8,111],[2,13,8,97],[1,15,8,39],[1,16,8,67],[3,17,8,84],[4,20,8,67],[1,24,8,39],[1,25,8,97],[1,8,9,97],[4,9,9,39],[2,13,9,97],[1,15,9,39],[8,16,9,67],[1,24,9,39],[1,25,9,97],[18,8,10,97],[18,8,11,97],[18,8,12,97],[18,8,13,97],[18,8,14,97],[18,8,15,97],[18,8,16,97],[15,8,17,97],[2,23,17,42],[1,25,17,97],[1,8,18,97],[2,9,18,135],[1,11,18,97],[2,12,18,135],[1,14,18,97],[2,15,18,135],[1,17,18,97],[2,18,18,135],[1,20,18,97],[4,21,18,42],[1,25,18,97],[1,8,19,97],[2,9,19,135],[1,11,19,97],[2,12,19,135],[1,14,19,97],[2,15,19,135],[1,17,19,97],[2,18,19,135],[1,20,19,97],[4,21,19,42],[1,25,19,97],[18,8,20,97]]
    function addHeads( uint256[][][] memory _heads) public onlyOwner{
        for (uint256 i = 0; i < _heads.length; i += 1) {
            head.push(_heads[i]);
        }
    }

    // [[6,10,11,222],[6,17,11,222],[1,10,12,222],[2,11,12,1],[2,13,12,35],[1,15,12,222],[1,17,12,222],[2,18,12,1],[2,20,12,35],[1,22,12,222],[4,7,13,222 ],[2,11,13,1],[2,13,13,35],[3,15,13,222],[2,18,13,1],[2,20,13,35],[1,22,13,222],[1,7,14,222 ],[1,10,14,222],[2,11,14,1],[2,13,14,35],[1,15,14,222],[1,17,14,222],[2,18,14,1],[2,20,14,35],[1,22,14,222],[1,7,15,222 ],[1,10,15,222],[2,11,15,1],[2,13,15,35],[1,15,15,222],[1,17,15,222],[2,18,15,1],[2,20,15,35],[1,22,15,222],[6,10,16,222],[6,17,16,222]]
    // [[6,10,11,156],[6,17,11,156],[1,10,12,156],[2,11,12,1],[2,13,12,35],[1,15,12,156],[1,17,12,156],[2,18,12,1],[2,20,12,35],[1,22,12,156],[4,7,13,156 ],[2,11,13,1],[2,13,13,35],[3,15,13,156],[2,18,13,1],[2,20,13,35],[1,22,13,156],[1,7,14,156 ],[1,10,14,156],[2,11,14,1],[2,13,14,35],[1,15,14,156],[1,17,14,156],[2,18,14,1],[2,20,14,35],[1,22,14,156],[1,7,15,156 ],[1,10,15,156],[2,11,15,1],[2,13,15,35],[1,15,15,156],[1,17,15,156],[2,18,15,1],[2,20,15,35],[1,22,15,156],[6,10,16,156],[6,17,16,156]]
    // [[6,10,11,197],[6,17,11,197],[1,10,12,197],[2,11,12,1],[2,13,12,35],[1,15,12,197],[1,17,12,197],[2,18,12,1],[2,20,12,35],[1,22,12,197],[4,7,13,197 ],[2,11,13,1],[2,13,13,35],[3,15,13,197],[2,18,13,1],[2,20,13,35],[1,22,13,197],[1,7,14,197 ],[1,10,14,197],[2,11,14,1],[2,13,14,35],[1,15,14,197],[1,17,14,197],[2,18,14,1],[2,20,14,35],[1,22,14,197],[1,7,15,197 ],[1,10,15,197],[2,11,15,1],[2,13,15,35],[1,15,15,197],[1,17,15,197],[2,18,15,1],[2,20,15,35],[1,22,15,197],[6,10,16,197],[6,17,16,197]]
    // [[6,10,11,141],[6,17,11,141],[1,10,12,141],[2,11,12,1],[2,13,12,35],[1,15,12,141],[1,17,12,141],[2,18,12,1],[2,20,12,35],[1,22,12,141],[4,7,13,141 ],[2,11,13,1],[2,13,13,35],[3,15,13,141],[2,18,13,1],[2,20,13,35],[1,22,13,141],[1,7,14,141 ],[1,10,14,141],[2,11,14,1],[2,13,14,35],[1,15,14,141],[1,17,14,141],[2,18,14,1],[2,20,14,35],[1,22,14,141],[1,7,15,141 ],[1,10,15,141],[2,11,15,1],[2,13,15,35],[1,15,15,141],[1,17,15,141],[2,18,15,1],[2,20,15,35],[1,22,15,141],[6,10,16,141],[6,17,16,141]]
    // [[6,10,11,237],[6,17,11,237],[1,10,12,237],[2,11,12,1],[2,13,12,35],[1,15,12,237],[1,17,12,237],[2,18,12,1],[2,20,12,35],[1,22,12,237],[4,7,13,237 ],[2,11,13,1],[2,13,13,35],[3,15,13,237],[2,18,13,1],[2,20,13,35],[1,22,13,237],[1,7,14,237 ],[1,10,14,237],[2,11,14,1],[2,13,14,35],[1,15,14,237],[1,17,14,237],[2,18,14,1],[2,20,14,35],[1,22,14,237],[1,7,15,237 ],[1,10,15,237],[2,11,15,1],[2,13,15,35],[1,15,15,237],[1,17,15,237],[2,18,15,1],[2,20,15,35],[1,22,15,237],[6,10,16,237],[6,17,16,237]]

    function addGlasseses( uint256[][][] memory _glasseses) public onlyOwner{
        for (uint256 i = 0; i < _glasseses.length; i += 1) {
            glasses.push(_glasseses[i]);
        }
    }

    // [[7,13,24,86],[1,13,25,86],[1,15,25,86],[1,17,25,86],[3,19,25,86],[3,13,26,86],[3,17,26,86],[1,21,26,86]]
    // [[7,13,23,86],[1,13,24,86],[2,15,24,86],[2,18,24,86],[2,15,25,86],[2,18,25,86],[7,13,27,29],[1,13,28,29],[2,15,28,29],[2,18,28,29],[2,15,29,29],[2,18,29,29]]
    // [[2,14,23,62],[1,17,23,62],[1,14,24,62],[2,16,24,62],[2,13,26,62],[1,16,26,62],[1,18,26,62],[2,13,27,62],[3,16,27,62],[2,14,29,62],[1,17,29,62],[1,14,30,62],[2,16,30,62]]

    function addAccessories( uint256[][][] memory _accessories) public onlyOwner{
        for (uint256 i = 0; i < _accessories.length; i += 1) {
            accessory.push(_accessories[i]);
        }
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
        return dataURI(_tokenId);
    }

    function dataURI(uint256 _tokenId) public view returns (string memory) {
        return buildMetaData(_tokenId);
    }

    function addColors(string[] memory _colors)  public onlyOwner{
        colors = _colors;
    }
    
    function createRect(uint256 _tokenId) public view returns (string memory){
        Seed memory seed = seedByToken[_tokenId];
        uint256[][] memory rectBody = body[seed.body];
        uint256[][] memory rectHead = head[seed.head];
        uint256[][] memory rectAccessory = accessory[seed.accessory];
        uint256[][] memory rectGlasses = glasses[seed.glasses];
        
        return DrawSVG._drawSVG(rectBody, rectHead, rectAccessory, rectGlasses, colors);
    }
}