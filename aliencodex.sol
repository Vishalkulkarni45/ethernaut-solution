// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../helpers/Ownable-05.sol';

contract AlienCodex is Ownable {

  bool public contact;
  bytes32[] public codex;

  modifier contacted() {
    assert(contact);
    _;
  }
  
  function make_contact() public {
    contact = true;
  }

  function record(bytes32 _content) contacted public {
    codex.push(_content);
  }

  function retract() contacted public {
    codex.length--;
  }

  function revise(uint i, bytes32 _content) contacted public {
    codex[i] = _content;
  }
}
//dynamic array are store at position 
//keccak(array.length)
//we need to find a index such that index = -keccak(1) mod 2^256
//we can change the owner by change in the slot of its variable