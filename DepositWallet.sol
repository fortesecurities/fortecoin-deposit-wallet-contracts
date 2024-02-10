// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DepositWallet {
    
    address public immutable ADMIN;
    IERC20 public immutable TOKEN;
    address public immutable SWEEP_ADDRESS;

    constructor(address admin, IERC20 token, address sweepAddress) {
        ADMIN = admin;
        TOKEN = token;
        SWEEP_ADDRESS = sweepAddress;
    }

    function balance() view public returns (uint256) {
        return TOKEN.balanceOf(address(this));
    }

    function sweep() public {
        sweep(TOKEN.balanceOf(address(this)));
    }

    function sweep(uint256 amount) public {
        TOKEN.transfer(SWEEP_ADDRESS, amount);
    }

    function transfer(IERC20 token, address to, uint256 amount) public {
        require(msg.sender == ADMIN, "DepositWallet: sender not admin");
        token.transfer(to, amount);
    }

    function transfer(address payable to, uint256 amount) public {
        require(msg.sender == ADMIN, "DepositWallet: sender not admin");
        to.transfer(amount);
    }
}
