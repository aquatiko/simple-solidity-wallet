// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
Transfer funds from user's own wallet to RohWallet
Check current balance in user's RohWallet
Send ETH from one RohWallet to another
Withdraw ETH from RohWallet to user's own wallet
All apis show currency in wei units
*/
contract RohWallet {

    mapping(address => uint) private userWalletBalance;

    function getWalletBalance() external view returns(uint){
        return userWalletBalance[msg.sender];
    }

    function addTokenIntoWallet() external payable {
        userWalletBalance[msg.sender] += msg.value;
    }

    function sendTokenToUser(address receiverAddress, uint amount) external {
        require(userWalletBalance[msg.sender] >= amount); 
        // Put this into transaction, safeMath
        userWalletBalance[msg.sender] -= amount;
        userWalletBalance[receiverAddress] += amount;
    }

    function withdraw(uint amount) external {
        require(amount <= userWalletBalance[msg.sender]);
        payable(msg.sender).transfer(amount);
        userWalletBalance[msg.sender] -= amount;
    }
}
