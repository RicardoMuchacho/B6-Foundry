## Bloque 6 - Foundry

Commands:

forge init 
forge build                        = compiles code
forge test                         = executes tests
forge test -vvvv                   = test details
forge test --match-test [testName] = run specific test
forge coverage                     = tested code coverage 

Testing:

types of test: 
-Unit: test unitario, input => expected output
-Fuzzing: makes multiple tests with random numbers, use to test edge cases

  
function setUp() = executes before the code, contracts go here
vm.addr(1) = generates random address
vm.expectRevert() = expects error in test, goes before the failing code
vm.startPrank() = impersonates a different address
vm.stopPrank() = stops impersonating the address

foundry allows to impersonate other addresses, not only your own, which is very useful when testing

Creating a test:

1. function testFirstTest() //use test as the first word
2. Logics
3. assert()
