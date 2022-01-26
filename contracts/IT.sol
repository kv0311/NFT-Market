pragma solidity ^0.8.6;

import "base64-sol/base64.sol";


import { INounsDescriptor } from './interfaces/INounsDescriptor.sol';
import { MultiPartRLEToSVG } from './MultiPartRLEToSVG.sol';

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";



contract IT is  
    Initializable,
    UUPSUpgradeable,
    OwnableUpgradeable {
    BlockchainSalaray public blockchainSalary;
    function initialize() public initializer {
        __Ownable_init();
    }
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner{
    }
}

contract BlockchainSalaray is IT {
    // uint fee;
    function setSalary(uint _salary ) public returns( uint) {
        // fee = _salary;
        return 123;
        // __gap = _salary;
    }
}