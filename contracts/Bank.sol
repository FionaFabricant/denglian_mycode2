// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/draft-IERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC1820Registry.sol";

interface TokenRecipient {     //接口tokenrecipient  唯一function是接收代币 返回是否成功接收
    function tokensReceived(address sender, uint amount) external returns (bool);
}

contract Bank is TokenRecipient{
    mapping(address => uint) public deposited;  //deposited 是地址和代币数量的映射
    address public immutable token;  

      // keccak256("ERC777TokensRecipient")
    bytes32 constant private TOKENS_RECIPIENT_INTERFACE_HASH =
        0xb281fc8c12954d22544db45de3159a39272895b169a852b314f9cc762e44c53b;

    IERC1820Registry private erc1820 = IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);

    constructor(address _token) {
        token = _token;       //代币地址 即camp2
        // erc1820.setInterfaceImplementer(address(this), TOKENS_RECIPIENT_INTERFACE_HASH, address(this));
    }

    function deposit(address user, uint amount) public {
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "Transfer from error");
        deposited[user] += amount;
    }

    function permitDeposit(address user, uint amount, uint deadline, uint8 v, bytes32 r, bytes32 s) external {
        IERC20Permit(token).permit(msg.sender, address(this), amount, deadline, v, r, s);
        deposit(user, amount);
    }
/*
    // 收款时被回调
    function tokensReceived(
        address operator,
        address from,
        address to,
        uint amount,
        bytes calldata userData,
        bytes calldata operatorData
    ) external {
        require(msg.sender == token, "invalid");
        deposited[from] += amount;
    }
*/
    // 收款时被回调
    function tokensReceived(address sender, uint amount) external override returns (bool) {
        require(msg.sender == token, "invalid");    //要求发送人不是合约 
        deposited[sender] += amount;               //给发送者存入一定数量的代币
        return true;
    }


}    