// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.3;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;


    constructor() {
        console.log("We are tomorrow. We are the builders of our dreams.");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
    }


    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}