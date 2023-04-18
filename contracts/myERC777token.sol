// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC777/ERC777.sol";

//erc777引入了回调函数

contract MyERC77token is ERC777{
   
    constructor() ERC777("MY777", "M777", new address[](0))
    {
        _mint(msg.sender, 1000 * 10 ** 18, "", "");
    }
}