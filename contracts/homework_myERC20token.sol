// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//作业 发行一个ERC20token 发行1000枚

contract Yara is ERC20{
    constructor() ERC20(unicode"Yu","Ya"){
        _mint(msg.sender,1000*10**18);
    }
}