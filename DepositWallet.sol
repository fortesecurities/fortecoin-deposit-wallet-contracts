// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DepositWallet {
    
    address public immutable SWEEP_ADDRESS;

    error ZeroBalance();

    constructor(address sweepAddress) {
        SWEEP_ADDRESS = sweepAddress;
    }

    function sweep(IERC20 token) public {
        uint256 balance = token.balanceOf(address(this));
        if (balance == 0) {
            revert ZeroBalance();
        }
        token.transfer(SWEEP_ADDRESS, balance);
    }
}
