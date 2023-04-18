// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

//tokensender的接口

import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/token/ERC777/IERC777Sender.sol";  //调用IERC777Sender
import "@openzeppelin/contracts/Introspection/ERC1820Implementer.sol";  //调用ERC1820注册表合约
import "@openzeppelin/contracts/token/ERC777/IERC777.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract TokenSender is ERC1820Implementer, IERC777Sender,Ownable{
    bool private allowTokensToSend;  //接口的开关 是否同意发送代币
    using SafeMath for uint256;
    bytes32 private constant TOKENS_RECIPIENT_INTERFACE_HASH=
    //常量编码值

    mapping(address=>address) public token;
    mapping(address=>address) public operator;
    mapping(address=>address) public from;
    mapping(address=>address) public to;
    mapping(address=>uint256) public amount;
    mapping(address=>bytes) public data;
    mapping(address=>bytes) public operatorData;
    mapping(address=>uint256) public balanceOf;

    //这里就是在注册表注册了啊
    //ERC1820注册表的合约地址
    //用合约地址实例化一个erc1820注册表的接口
    IERC1820Registry internal constant _ERC1820_REGISTRY=IERC1820Registry{
        0X1820A4B...
    }

    //bool _setInterface 是否为当前地址设置接收币的接口
    //如果为当前地址设置接收币的接口，则当前地址可以收币
    constructor(bool _setInterface) public{
        if(_setInterface){
            ERC1820_REGISTRY.setInterfaceImplementer(
                address(this),
                TOKENS_SENDER_INTERFACE_HASH,
                address(this)
            );
        }
        _registerInterfaceForAddress(TOKENS_SENDER_INTERFACE_HASH,msg.sender);
        allowTokensToSend(this);
    }

    function tokensToSend(..) external {

    }

    //是否打开发送代币的接口的开关：开
    //允许发送代币
    function acceptTokensToSend() public onlyOwner{

    }

    //关闭发送代币的接口的开关
    //不允许发送代币
    function rejectTokensToSend() public onlyOwner{

    }



}