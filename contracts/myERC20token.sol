// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract myERC20token is ERC20{
    constructor() ERC20(unicode"集训营二期","CAMP2" ){     //初始化代币名称和符号
        _mint(msg.sender,1000*10**18);    //代币数量1000个
    }
}

//approve和transfer的过程

//1.用户user调用erc20的approve(bank,数量)
//2.用户user调用bank的deposit() 完成存款

//transferFrom(msg.sender,address(this),amount)
//bank用transferFrom从用户user中使用一定数量的币,转到自己的地址下当前token的地址。将币从用户转到当前的token合约

//myerc20token中：
//approve:user允许bank转账一定数量的代币
//transfer：参数是目标地址，参数二是转账数量

//bank中：
//deposit:参数一是user的地址 参数二是转账的数量
//deposited:参数是转账的对象 返回该目标地址的余额

//1.token的approve方法中 user允许bank转账一定数量的代币
//2.token的transfer方法中，填入目标地址和转账数量
//3.bank的deposit方法中，填入user地址和允许转账的数量

//4.bank的deposited mapping中，填入目标地址，返回余额

//为什么bank部署到token的地址0xd7Ca4e99F7C171B9ea2De80d3363c47009afaC5F
//bank的地址即token地址
//approve bank一定的额度
//deposit user存入一定金额的币
//deposited填入用户地址 得到用户余额

//erc20转账要两步 先approve 后deposit 耗费gas多 用户体验不好 所以有了erc777
