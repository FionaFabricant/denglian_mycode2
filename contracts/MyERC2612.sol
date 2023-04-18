// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

//erc2612 可以线下签名 在转账交易时将签名信息提交到链上
//用到erc20的permit方法. 继承ERC20Permit
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract ERC2612 is ERC20Permit{
    constructor() ERC20("ERC2612","ERC2612") ERC20Permit("ERC2612"){
        _mint(msg.sender,2612*10**18);
    }
}