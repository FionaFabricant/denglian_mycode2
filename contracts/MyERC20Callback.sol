// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

//erc20中加入回调函数

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";

//代币接受者的接口 唯一功能：接收代币
interface TokenRecipient{
    function tokensReceived(address sender,uint amount) external returns(bool);
}

contract MyERC20Callback is ERC20{
    using Address for address; //Address函数是个啥？

    constructor() ERC20("MyERC20","MyERC20"){
        _mint(msg.sender,1000*10**18);
    }

    function transferWithCallback(address recipient,uint256 amount) external returns(bool){
    _transfer(msg.sender,recipient,amount);

    if(recipient.isContract()){ //如果接收者是合约的话 判断是不是有tokenreceived方法 有就调用这个合约的tokensReceived方法 没有就报错
        bool rv=TokenRecipient(recipient).tokensReceived(msg.sender,amount);
        require(rv,"no tokensReceived");
    }

    return true; //如果接收者不是合约 直接返回true 即有回调函数
}

}

