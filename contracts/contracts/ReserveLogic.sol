// SPDX-License-Identifier: agpl-3.0
pragma solidity >=0.4.22 <0.9.0;

import {SafeMath} from 'openzeppelin-solidity/contracts/math/SafeMath.sol';
import {DataTypes} from './DataTypes.sol';

/**
 * @title ReserveLogic library
 * @author Ormi
 * @notice Implements the logic to update the reserves state
 */
library ReserveLogic {
  using SafeMath for uint256;
  
  /**
   * @dev Emitted when the state of a reserve is updated
   **/
  event ReserveDataUpdated(
    address indexed assetAddress,
    uint256 interestRate,
    uint256 totalAsset
  );

  //
  // using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
  

  /**
   * @dev Updates the liquidity cumulative index and the variable borrow index.
   * @param reserve the reserve object
   **/
  function updateData(
    DataTypes.ReserveData storage reserve,
    address assetAddress,
    address fromAddress,
    uint40 amount) internal {
      if (reserve.assetAddress == address(0))
          reserve.assetAddress = assetAddress;
      
      require(reserve.assetAddress == assetAddress, 
        'the asset deposited must be the same type as the reserve');
      uint40 initialInterestRate = reserve.interestRate;
      uint256 newTotalAsset = reserve.totalAsset + amount;
      uint40 newInterestRate = uint40(initialInterestRate - initialInterestRate* (amount / newTotalAsset));
      
      reserve.totalAsset = newTotalAsset;
      reserve.interestRate = newInterestRate;
      reserve.lastUpdateTimestamp = uint40(block.timestamp);
      reserve.reserveContent[fromAddress] += amount;
      emit ReserveDataUpdated(assetAddress, newInterestRate, newTotalAsset);
  }
  
  function userAccountBalance(
    DataTypes.ReserveData storage reserve, 
    address assetAddress,
    address fromAddress) internal view returns (uint256) {
        
    } 
}