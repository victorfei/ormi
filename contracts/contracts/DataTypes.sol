// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

library DataTypes {
  // refer to the whitepaper, section 1.1 basic concepts for a formal description of these properties.
  struct ReserveData {
    uint256 totalAsset;
    address assetAddress;
    
    uint40 interestRate;
    uint40 lastUpdateTimestamp;
    
    // {'user_address': count}
    mapping(address => uint256) reserveContent;
 
  }
}