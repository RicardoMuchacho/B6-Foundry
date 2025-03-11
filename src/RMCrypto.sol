// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract RMCrypto is ERC20, Ownable, ERC20Burnable {
    uint256 public fixedEthPrice = 1000; //1000 tokens for 1 eth
    uint256 public initSupply = 1_000_000 * 10**decimals();

    constructor() ERC20("RickM Crypto", "RM") Ownable(msg.sender) {
        _mint(msg.sender, 1000 * 10**decimals());
        _mint(address(this), initSupply);
    }
    //variables

    //modifiers

    //events

    //external functions
    function mintTokens(uint256 amount) public onlyOwner {
        _mint(address(this), amount);
    }

    function burnTokens(uint256 amount) public onlyOwner {
        _burn(address(this), amount);
    }

    function buyTokens() public payable {
        uint256 tokens = msg.value * fixedEthPrice;
        require(balanceOf(address(this)) >= tokens, "Not enough tokens available");

        _transfer(address(this), msg.sender, tokens);
    }

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}