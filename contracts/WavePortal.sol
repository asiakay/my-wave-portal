// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
// pragma experimental ABIEncoderV2;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    /* initialized to 0 */

    uint256 private seed;
    /* seed: helps generate a random number
    */
    event NewWave(address indexed from, uint256 timestamp, string message);
    /* an event is an inheritable member of a contract. An event is emitted, it stores the arguments passed in transaction logs */
    struct Wave {
        address waver;
        /* the address of the user who sent the wave */
        string message;
        /* the message the user sent */
        uint256 timestamp;
        /* the timestamp of when the user waved */
    }
    Wave[] waves;
    /* waves variable allows storage of an array of structs. It holds the wave/info that users send */
    mapping(address => uint256) public lastWavedAt;
    /* (address => uint mapping): associates an address with a number. 
    Here is where the address with the last time the user waved is stored */
    
    constructor() payable {
        console.log("Smarty contract has been constructed");
        /* setting the initial seed below */
        seed = (block.timestamp + block.difficulty) % 100;
        /* block.difficulty and block.timestamp are combined to create a random number. 
        block.difficulty: tells miners how hard the block will be to mine based on the transactions in the block.
        block.timestamp:the Unix timestamp that the block is being processed
        seed: will change every time a user sends a new wave. 
         */
    }

    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
            /* the above requires that the current timestamp is at least 15 mins greater than 
            the last stored timestamp to send a new wave. */
            );

            lastWavedAt[msg.sender] = block.timestamp;
            /* above line updates the current timestamp we have for the user */

            totalWaves += 1;
            console.log("%s has waved", msg.sender);
            /* msg.sender is the address of the person who called the wave */
            /* _message is the message that user sends from the frontend */
            waves.push(Wave(msg.sender, _message, block.timestamp));
            /* where the wave data is stored in the array */
            seed = (block.difficulty + block.timestamp + seed) % 100;
            /* (above line) generated a new seed for the next user that sends a wave */
            // console.log("Random # generated: %d", seed);
            /* (below line) giving a 50% chance that the user wins the prize */
            if (seed <= 50){
                console.log("%s has won the prize!", msg.sender);
                /* code for sending prize (shown below) */
                uint256 prizeAmount = 0.0001 ether;
                /* initiating a prizeAmount of .0001 with the Solidity keyword ether */
                require(
                    prizeAmount <= address(this).balance,
                    "Trying to withdraw more money than the contract has."
                    /* if prizeAmount less than or equal to contract's account balance */
                    /* then require will kill the transaction for the reason stated above*/
                );
                (bool success, ) = (msg.sender).call{value: prizeAmount}("");
                /* (msg.sender).call{value: prizeAmount}("") is the where the prizeAount is sent */
                /* value passed through the transaction is the prizeAmount */
                require(success, "Failed to withdraw money from contract.");
                /* require success verifies that the transaction was a success ??*/
            }

            emit NewWave(msg.sender, block.timestamp, _message);
        }
        function getAllWaves() public view returns (Wave[] memory) {
        return waves;
        }
        function getTotalWaves() public view returns (uint256) {
        // console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}
