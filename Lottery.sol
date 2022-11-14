// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.4.17;

contract Lottery {
    address public manager;
    address[] public players; 


    //getting address of the contract 
    function Lottery() public {
        manager = msg.sender;
    }

    //geting eth from players
    function enter() public payable {
        require(msg.value > 0.01 ether );
        players.push(msg.sender);
    }
    //random number generator
    function randomNumber() private view returns (uint) {
       return uint(keccak256(block.difficulty , now , players));
    }

    //winner selecting
    function pickWinner() public restricted {
         

        uint index = randomNumber() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0);// resetting the players array 
    }

    //funtion modifier

    modifier restricted(){
        require(msg.sender == manager); //only manager can use pickWiner function
        _;
    }

    //get all the players
    function getPlayers() public view returns (address[]){
        return players;

    }

}