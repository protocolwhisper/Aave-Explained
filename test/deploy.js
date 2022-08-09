const {expect , assert} = require("chai");
const {BigNumber} = require("ethers");
const {ethers , waffle , artifacts} = require("hardhat");

const hre = require("hardhat");

const {DAI , DAI_WHALE , POOL_ADDRESS_PROVIDER} = require("../config");

describe("Deploy a Flash Loan", function (){
    it("Should take a flash loan and be able to return it", async function (){
        const flashloanexample = await ethers.getContractFactory("FlashLoanExample");
        // This is the address of the PoolAddressProvider that can be fond in https://docs.aave.com/developers/deployed-contracts/v3-mainnet/polygon
        const _flashloanexample = await flashloanexample.deploy(POOL_ADDRESS_PROVIDER);
        await _flashloanexample.deployed();

        const token = await ethers.getContractAt("IERC20", DAI);
        const BALANCE_AMOUNT_DAI = ethers.utils.parseEther("2000");

        /// Here we can inpersonate the address of the dai_whale to be able to send the transaction usding that account

        await hre.network.provider.request({
            method : "hardhat_impersonateAccount",
            params: [DAI_WHALE],
        });

        const signer = await ethers.getSigner(DAI_WHALE);
        
        await token
            .connect(signer)
            .transfer(_flashloanexample.address, BALANCE_AMOUNT_DAI); // Send our contract 2000 DAI from the whales account 

        const tx = await _flashloanexample.createFlashLoan(DAI, 1000);
        await tx.wait();

        const remainingBalance = await token.balanceOf(_flashloanexample.address);
        expect(remainingBalance.lt(BALANCE_AMOUNT_DAI)).to.be.true;

    })
})