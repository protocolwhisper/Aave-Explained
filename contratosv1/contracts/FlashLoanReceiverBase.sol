pragma solidity 0.8.9;


import "@aave/core-v3/contracts/interfaces/IPool.sol";
import "./IFlashLoanReceiver.sol";
import "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";

/**
 * @title FlashLoanReceiverBase
 * @author Aave
 * @notice Base contract to develop a flashloan-receiver contract.
 */
abstract contract FlashLoanReceiverBase is IFlashLoanReceiver {
  IPoolAddressesProvider public immutable override ADDRESSES_PROVIDER;
  IPool public immutable override POOL;

  constructor(IPoolAddressesProvider provider) {
    ADDRESSES_PROVIDER = provider;
    POOL = IPool(provider.getPool());
  }
}