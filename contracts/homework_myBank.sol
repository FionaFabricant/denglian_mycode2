// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/*
作业：编写一个金库Vault合约：
1.编写deposit方法 实现ERC20存入Vault 并记录每个用户存款金额（approve/transferFrom）
2.编写withdraw方法，提取用户自己的存款

进阶练习：
使用ERC2612标准token 使用签名的方式deposit
*/

interface TokenRecipient {     //接口tokenrecipient  唯一function是接收代币 返回是否成功接收
    function tokensReceived(address sender, uint amount) external returns (bool);
}

interface TokenWithdrawer {     //接口tokenrecipient  唯一function是接收代币 返回是否成功接收
    function tokensWithdraw(uint amount) external;
}

contract Vault is TokenRecipient,TokenWithdrawer{
    mapping(address=>uint256) public balanceOf;

    address public immutable token;
    constructor(address _token){ //deploy vault的时候要填入目标合约的地址 
        token=_token;
    }
    //deposit方法 approve+transferFrom
    function deposit(address user, uint amount) public{
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "Transfer from error");
        balanceOf[user] += amount;
    }

    //withdraw方法
    function tokensWithdraw(uint amount) public{
        balanceOf[address(this)]-=amount;
    }

    //收款时被回调
    function tokensReceived(address sender, uint amount) external override returns (bool) {
        require(msg.sender == token, "invalid");    //要求发送人不是合约 
        balanceOf[sender] += amount;               //给发送者存入一定数量的代币
        return true;
    }
}