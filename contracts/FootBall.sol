pragma solidity ^0.8.2;
import "./ERC721.sol";

contract FootBall is ERC712{
    string public name;
    string public symbol;
    uint256 public tokenCount;
    mapping(uint256 => string) private _tokenURIs;
    constructor(string memory _name, string memory _symbol){
        name =_name;
        symbol =_symbol;
    }

    function tokenURI(uint256 tokenID) public view returns (string memory){
            require(_owners[tokenID] != address(0),"token id is invalid");
            return _tokenURIs[tokenID];
    }
    function mint(string memory _tokenURI) public {
        tokenCount +=1;
        _balances[msg.sender] = 1;
        _owners[tokenCount] = msg.sender;
        _tokenURIs[tokenCount] = _tokenURI;

        emit Transfer(address(0),  msg.sender, tokenCount);
    }

     function supportInterface(bytes4 interfaceID) public pure override returns (bool){
        return interfaceID == 0x80ac58cd || interfaceID == 0x5b5e139f;
    }
}