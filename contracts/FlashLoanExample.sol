//SPDX-License-Identifier : MIT 

pragma solidity ^0.8.10;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract FlashLoanExample is FlashLoanSimpleReceiverBase {
    using SafeMath for uint;
    event Log(address asset , uint val);

    constructor (IPoolAddressesProvider provider) FlashLoanSimpleReceiverBase(provider){
        //First param addres of the PoolContract that is wrapped around the Interface IPoolAddressesProvider
    }

    // 4 Me this is more like u instanciate the addy througth the interfaces so now u addy can interact with all the functions 
    // But for me to know that the provider must implements all the functions described in those interface otherwise it'll not make any sense of having it 

    function createFlashLoan(address asset , uint amount) external {
        address reciever = address(this); // Calling the same addy of the SC
        bytes memory params = "" ;//We can use this to pass arbitrary data to executeOperation
        uint16 referralCode = 0;

        POOL.flashLoanSimple(reciever , asset , amount , params , referralCode);
    }

    function executeOperation(address asset , uint256 amount , uint256 premium , address initiator , bytes calldata params) external returns (bool) {
        // Do things like arbitrage here 
        //abi.decode(params) to decode params 

        uint amountOwing = amount.add(premium);
        IERC20(asset).approve(address(POOL), amountOwing);
        emit Log(asset , amountOwing);
        return true;
    }
}
