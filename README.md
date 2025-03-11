# Foundry Testing ⚡️

This repository serves as an introduction to Foundry and Solidity testing fundamentals.

[Foundry](https://book.getfoundry.sh/) is a blazing fast, portable, and modular toolkit for Ethereum application development written in Rust. It has become one of the most popular frameworks in modern Solidity development, offering fast and efficient testing, deployment, and interaction with Ethereum smart contracts.

## 📜 Contracts

### `Calculator.sol` ➗
A classic calculator contract with basic arithmetic operators, designed to demonstrate Foundry testing fundamentals.

### `RMCrypto.sol` 💰
An ERC20 contract that includes mint, burn, and owner functionalities, imported for testing.

## 🧪 Testing

The project includes both **unit tests** and **fuzz tests** to ensure the correct behavior of the contracts and handle edge cases:

- **Unit Tests**: Ensures that all functions perform as expected and verifies error handling with `vm.expectRevert()`.
- **Fuzz Testing**: Used on critical functions to ensure the contract behaves correctly across a wide range of inputs.

### 📊 Test Coverage Results

Here is a summary of the test coverage for each file in the project:

| **File**            | **% Lines** | **% Statements** | **% Branches** | **% Functions** |
|---------------------|-------------|------------------|----------------|-----------------|
| `src/Calculator.sol` | 100.00% (24/24) | 100.00% (17/17) | 100.00% (2/2)  | 100.00% (7/7)   |
| `src/RMCrypto.sol`   | 100.00% (13/13) | 100.00% (9/9)   | 100.00% (2/2)  | 100.00% (5/5)   |
| **Total**            | **100.00% (37/37)** | **100.00% (26/26)** | **100.00% (4/4)** | **100.00% (12/12)** |

This table shows that all code in the contracts has been fully covered.

## 📚 Foundry Documentation

For more information on Foundry and how to use it, refer to the official documentation:  
[Foundry Documentation](https://book.getfoundry.sh/)
