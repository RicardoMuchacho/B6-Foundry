// SPDX-Licence-Identifier: MIT
pragma solidity >= 0.8.24;

import "../src/Calculator.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

contract CalculatorTest is Test {
  Calculator calculator;
  uint256 public firstResult = 10;
  address public randomUser = vm.addr(1);

  // called before each test case
  function setUp() public{
     calculator = new Calculator(firstResult);
  }

  // Unit Testing
  function test_initialized() public view {
     uint256 _result = calculator.result();
     assert(_result == firstResult);
  }

  function test_addition() public {
    calculator.addition(5, 10);
    assert(calculator.result() == 15);
  }

  function test_substraction() public {
    calculator.substraction(15, 10);
    assert(calculator.result() == 5);
  }

  function test_multiplication() public {
    calculator.multiplication(5, 2);
    assert(calculator.result() == 10);
  }

//A good practice is to use the pattern test_Revert[If|When]_Condition
  function test_RevertBigNumberMultiplication() public {
    vm.expectRevert();
    calculator.multiplication(2, 2**256-1);
  }

  function test_correctlyCallDivision() public {
    // console.log("test", msg.sender);
    // console.log(calculator.admin());
    uint256 _result = calculator.division(5, 5);
    assert(_result == 1);
  }

// Use startPrank and stopPrank to impersonate addresses
  function test_RevertNotAdminDivision() public {
    vm.startPrank(randomUser);

    vm.expectRevert();
    calculator.division(5, 5);

    vm.stopPrank();
  }

  function test_RevertZeroDivision() public {
    vm.expectRevert();
    calculator.division(5, 0);
  }

  // Fuzz Testing
}