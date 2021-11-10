// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.0;
pragma experimental ABIEncoderV2;

interface IOrmiIncentivesController {
  function handleAction(
    address user,
    uint256 userBalance,
    uint256 totalSupply
  ) external;
}