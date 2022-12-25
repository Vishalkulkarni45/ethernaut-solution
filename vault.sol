// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
  bool public locked;
  bytes32 private password;

  constructor(bytes32 _password) {
    locked = true;
    password = _password;
  }

  function unlock(bytes32 _password) public {
    if (password == _password) {
      locked = false;
    }
  }
}
// we can access the private variables
//web3.eth.getStorageAt("Vault.address", 1, console.log)
//there are 2*256 slots ,each slot has 32 bytes
//password takes slot 2 as it can not fit in slot 1 because of bool(locked)
//pass=web3.eth.getStorageAt("Vault.address", 1, console.log) 
//we can run unlock(pass) to pass the challenge
