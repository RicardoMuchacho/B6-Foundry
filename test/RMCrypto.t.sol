// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24;

import "../src/RMCrypto.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

contract RMCryptoTest is Test {
    RMCrypto tokenRM;
    address randUser = vm.addr(1);
    address owner = vm.addr(2);

    function setUp() public {
        vm.startPrank(owner);
        tokenRM = new RMCrypto();
        vm.stopPrank();
    }

    function test_tokenRMInitialized() public view {
       assertEq(tokenRM.name(), "RickM Crypto");
       assertEq(tokenRM.symbol(),"RM");
       assertEq(tokenRM.balanceOf(address(tokenRM)), tokenRM.initSupply());
       assertEq(tokenRM.balanceOf(owner), 1000*10**tokenRM.decimals());
    }
    function test_mintTokens() public {
        vm.startPrank(owner);
        
        uint256 tokenAmount = 1 ether;

        tokenRM.mintTokens(tokenAmount);
        uint256 contractBalance = tokenRM.balanceOf(address(tokenRM));
        assertEq(contractBalance, tokenRM.initSupply() + tokenAmount);

        vm.stopPrank();
    }

    function test_burnTokens() public {
        vm.startPrank(owner);

        uint256 tokenAmount = 1 ether;

        tokenRM.burnTokens(1 ether);
        uint256 contractBalance = tokenRM.balanceOf(address(tokenRM));
        assertEq(contractBalance, tokenRM.initSupply() - tokenAmount);  

        vm.stopPrank();
    }

    function test_buyTokens() public {
        vm.deal(randUser, 3 ether);
        vm.startPrank(randUser);

        uint256 ethAmount = 2 ether;
        uint256 rmAmount = ethAmount * tokenRM.fixedEthPrice(); // 1 ETH = 1000 RM
        tokenRM.buyTokens{value: ethAmount}();

        assertEq(tokenRM.balanceOf(randUser), rmAmount); 
        assertEq(tokenRM.balanceOf(address(tokenRM)), tokenRM.initSupply() - rmAmount);

        vm.stopPrank();
    }

    function test_RevertMoreThanSupplyBuyTokens() public {
        vm.deal(randUser, tokenRM.initSupply() + 1 ether);
        vm.startPrank(randUser);

        uint256 tokenAmount = tokenRM.initSupply() + 0.5 ether;

        vm.expectRevert();
        tokenRM.buyTokens{value: tokenAmount}();

        vm.stopPrank();
    }
    function test_withdraw() public {
        uint256 tokenAmount = 2 ether;
        buyTokensForTest(tokenAmount);
        vm.startPrank(owner);
        
        tokenRM.withdraw();
        assertEq(owner.balance, tokenAmount);
        
        vm.stopPrank();
    }

    function test_revertNotOwnerWithdraw() public {
        vm.startPrank(randUser);
        
        vm.expectRevert();
        tokenRM.withdraw();
        
        vm.stopPrank();
    }

    // Fuzz Testing 
    function test_FuzzBuyTokens(uint256 ethAmount) public {
        vm.assume(ethAmount > 0 && ethAmount < 100 ether);
        vm.deal(randUser, 100 ether);

        vm.startPrank(randUser);
        
        buyTokensForTest(ethAmount);
        
        vm.stopPrank();
    }

    // helpers
    function buyTokensForTest(uint256 amount) internal {
       tokenRM.buyTokens{value: amount}();
    }
}