# Aave-Explained
A Brief Explanation of Aave protocols with notes and Examples.

## How do Flash Loans Work?

  - Write a smart contract that has a transaction that uses a flash loan. Let's assume the function is createFlashLoan. 
  - Your contract calls for a function on a Flash Loan provider , like Aave , indicating which asset you want and how much of it.
  - The flash loan provider sends the assets to your contracts and calls back into your contract for a different function executeOperation. 
  - ExecuteOPeration is all the custom code you must have written, you do here, whatever you think you have to do will the money and then you approve back    Aave to withdraw back the borrowed assets , along with a fee. The flash Loan provider takes back the assets it gave you, along with the premium(asset).

There can be a lot of uses cases of a Flash loan but we'll talk about Arbitrage

## Arbitrage Workflow 
![Arbitrage with a flash loan](https://bafkreib53uw4lqautjadsjan6g6gxumultfywmmitj7srmh4uwxqdw2ksm.ipfs.nftstorage.link/)
