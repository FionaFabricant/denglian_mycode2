// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
 
contract myERC721 is ERC721URIStorage{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721(unicode"集训营二期学员卡",CAMP2);

    function mint(address student, string memory tokenURI) public returns(uint256){
        
    }
 
 
}