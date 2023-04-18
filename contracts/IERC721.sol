// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

Interface IERC721{
    name()
    symbol()
    tokenURL()

    balanceOf()
    ownerOf()

    safeTransferFrom()
    transferFrom()

    approve()
    setApproveForAll()
    getApproved()
    isApprovedForAll()
}