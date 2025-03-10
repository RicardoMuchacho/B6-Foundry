// SPDX-Licence-Identifier: MIT
pragma solidity >= 0.8.24;

contract Calculator {
  uint256 public result;
  address public admin;
  constructor(uint256 _result){
    result = _result;
    admin = msg.sender;
  }

  // events
  event Operation(string operationType, uint256 n1, uint256 n2, uint256 result);

  // modifiers
  modifier onlyAdmin() {
    require(msg.sender == admin, "only admin allowed");
    _;
  }

  // functions

  //1. Addition
  function addition(uint256 n1, uint256 n2) external returns(uint256 _result){
    _result = n1 + n2;
    result = _result;

    emit Operation("addition", n1, n2, result);
  }
  //2. Subtraction
  function substraction(uint256 n1, uint256 n2) external returns(uint256 _result) {
    _result = n1 - n2;
    result = _result;

    emit Operation("substraction", n1, n2, result); 
  }
  //3. Multiplication
  function multiplication(uint256 n1, uint256 n2) external returns(uint256 _result) {
    _result = n1 * n2;
    result = _result;

    emit Operation("multiplication", n1, n2, result);
  }
  //4. Division
  function division(uint256 n1, uint256 n2) external onlyAdmin returns(uint256 _result) {
    _result = n1/ n2;
    result = _result;

    emit Operation("division", n1, n2, result);
  }
}