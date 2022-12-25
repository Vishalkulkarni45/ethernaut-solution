// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Buyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}
//    function price() external view returns (uint256) {
//         return challenge.isSold() ? 0 : 100;
//     }

//there is change in the state of isSold
//when isSold false set the price to 100 and price to 0 when isSold is
//when the Shop first calls price function it returns 100 and when it calls price for send time it seta price to 0
