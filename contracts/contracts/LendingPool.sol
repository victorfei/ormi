// SPDX-License-Identifier: agpl-3.0
pragma solidity >=0.4.22 <0.9.0;
import {DataTypes} from './DataTypes.sol';
import {ReserveLogic} from './ReserveLogic.sol';


contract LendingPool {

  /**
   * @dev Emitted on deposit()
   **/
  event Deposit(
    address indexed assetAddress,
    address user,
    address indexed fromAddress,
    uint256 amount
  );
 
  /**
   * @dev Emitted on withdraw()
   **/
  event Withdraw(
    address indexed assetAddress,
    address user,
    address indexed fromAddress,
    uint256 amount,
    address indexed toAddress
  );
  using ReserveLogic for DataTypes.ReserveData;
  // {'token_address': reserveData}  
  mapping(address => DataTypes.ReserveData) public _reserves;

    /**
      * @dev Deposits an `amount` of underlying asset into the reserve, receiving in return overlying oTokens.
      * - E.g. User deposits 100 USDC and gets in return 100 oUSDC
     **/
    function deposit(
        address assetAddress,
        uint256 amount,
        address fromAddress) external {
        DataTypes.ReserveData storage reserve = _reserves[assetAddress];
            
        require((reserve.assetAddress == address(0) || assetAddress == reserve.assetAddress), 
            "deposit asset address and reserve address must be the same");
            
        reserve.updateData(assetAddress, fromAddress, uint40(amount));
            
        emit Deposit(assetAddress, msg.sender, fromAddress, amount);
    }
    
 /**
   * @dev Withdraws an `amount` of underlying asset from the reserve, burning the equivalent aTokens owned
   * E.g. User has 100 aUSDC, calls withdraw() and receives 100 USDC, burning the 100 aUSDC
   * @return The final amount withdrawn
   **/
  function withdraw(
    address assetAddress,
    address fromAddress,
    uint256 amount,
    address toAddress
  ) external returns (uint256) {
      DataTypes.ReserveData storage reserve = _reserves[assetAddress];
      require((reserve.assetAddress == address(0) || assetAddress == reserve.assetAddress), 
        "withdraw asset address and reserve address must be the same");
            
      uint256 userBalance = reserve.userAccountBalance(assetAddress, fromAddress);
      
      uint256 amountToWithdraw = amount;
      
      if (amountToWithdraw > userBalance)
          amountToWithdraw = userBalance;
      
      // TODO: Validate withdraw logic.
      reserve.updateData(assetAddress, fromAddress, -uint40(amountToWithdraw));
      
      // emit Withdraw(assetAddress, msg.sender, fromAddress, amountToWithdraw, toAddress);
      
      return amountToWithdraw;
  }
}