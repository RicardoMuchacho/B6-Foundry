// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24;

import "../src/RMCrypto.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

contract RMCrypto is Test {
    RMCrypto crypto;

    function setUp() {
        crypto = new RMCrypto();
    }

    //external functions
    function test_mintTokens(uint256 amount) public onlyOwner virtual {
        console.log("test");
        _mint(address(this), amount);
    }

    function test_burnTokens(uint256 amount) public onlyOwner virtual {
        _burn(address(this), amount);
    }

    function test_buyTokens() public payable {
        uint256 tokens = msg.value * fixedEthPrice;
        require(balanceOf(address(this)) >= tokens, "Not enough tokens available");

        _transfer(address(this), msg.sender, tokens);
    }

    function test_withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}