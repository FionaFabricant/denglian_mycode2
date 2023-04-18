// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;


interface ERC777Token{
    function name() 
    function symbol()
    function totalSupply()
    function balanceOf（address holder）
    function granularity()    //最小挖矿/发送/销毁粒度
    //相比erc20 少了decimal 因为erc777默认精度就是18 不可修改 

    function defaultOperators() public view returns(address[] memory)
    //获取代币合约的默认的操作员列表
    function isOperatorFor(address operator,address holder)
    //判断 如果operator是holder的操作员 就返回true 否则返回false
    
    function authorizeOperator(address operator)
    function revokeOperator(address operator)

//转账的方法 send operatorSend  burn operatorBurn
    //send方法取代了erc20的transfer方法
    function send(address to,uint256 amount,bytes calldata data) external;
    function operatorSend(address from,address to,uint256 amount,bytes calldata data,bytes calldata operatorData)
    //每个代币交易都包含data和operatorData字段 用于传递持有者的数据和操作员的数据

     function burn(uint256 amount,bytes calldata data) external;
     function operatorBurn(address from,uint256 amount,bytes calldata data,bytes calldata operatorData)external;
     //操作员也可以burn operatorBurn

//事件
     event Sent

     event Minted

     event Burned

     event AuthorizedOperator

     event RevokedOperator

//发送接口合约
    //在erc1820注册表查找到发送接口合约之后 调用这个接口
    function tokensToSend()
    //接收代币发送
    function acceptTokensToSend()
    //拒绝代币发送
    function rejectTokensToSend()

//接收接口合约
    //在erc1820注册表找到接收接口合约之后 调用这个接口
    function tokensReceived()
    //拒绝接收代币
    function acceptTokens()
    //同意接收代币
    function rejectTokens()


}
