pragma solidity ^0.8.6;
contract ERC712 {
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    // function balanceOf(address _owner) external view returns (uint256);
    // function ownerOf(uint256 _tokenId) external view returns (address);
    // function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
    // function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
    // function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
    // function approve(address _approved, uint256 _tokenId) external payable;
    // function setApprovalForAll(address _operator, bool _approved) external;
    // function getApproved(uint256 _tokenId) external view returns (address);
    // function isApprovedForAll(address _owner, address _operator) external view returns (bool);
    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;
    mapping(uint256 => address) internal _tokenApprovals;
    mapping(address => mapping(address => bool)) private  _operatorApprovals; 
    function balanceOf(address _owner) external view returns (uint256){
        require(_owner!= address(0),"Address is zero");
        return _balances[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address ){
        address owner = _owners[_tokenId];
        require(owner != address(0), "Token Id does not exist");  
        return owner;
    }
    /* Enable/Disable Operator */
    function setApprovalForAll(address operator, bool approved) external{
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }
    function isApprovedForAll(address owner, address operator) public view returns (bool){
        return _operatorApprovals[owner][operator];
    }
    function approve(address approved, uint256 tokenId) public payable{
        address owner = _owners[tokenId];
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender), "msg.sender is not the owner of operator");
        _tokenApprovals[tokenId] = approved;
        emit Approval(owner, approved, tokenId);
    }
    function getApproved(uint256 tokenId) public view returns (address){
        require(_owners[tokenId] != address(0),"token id is invalid");
        return _tokenApprovals[tokenId];
    }
    function transferFrom(address from, address to, uint256 tokenId) public payable{
        address owner = ownerOf(tokenId);
        require(
            msg.sender == owner ||
            msg.sender == getApproved(tokenId) ||
            isApprovedForAll(owner, msg.sender),
            "Msg.sender is not the owner approved for transfer"
        );
        require(owner == from, "from address is not owner");
        require(to != address(0), "Address is the zero address");
        require(_owners[tokenId] != address(0), "Token id is not exist");
        approve(address(0), tokenId);
        _balances[from] -=1;
        _balances[to] +=1;
        _owners[tokenId] = to;
        emit Transfer(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public payable{
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(), "Receiver not implemented");
    } 
    function _checkOnERC721Received() private pure returns (bool){
        return true;
    }
    function safeTransferFrom(address from, address to, uint256 tokenId) external payable{
        safeTransferFrom(from, to, tokenId, "");
    }
    function supportInterface(bytes4 interfaceID) public pure virtual returns (bool){
        return interfaceID == 0x80ac58cd;
    }
}
 