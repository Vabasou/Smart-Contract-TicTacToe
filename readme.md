# TicTacToe Ethereum Contract

## Tasks
1. Describe the logic of the smart contract business model that the smart contract will implement
2. Implement the business logic described in the first step as a smart contract in Solidity language
3. Test the smart contract on the Ethereum LAN and the Ethereum test network
4. Review the performance of the smart contract using the Ethereum test network Etherscan "logs"
5. Create a decentralized Front-End application (website or mobile application) that enables communication with the smart contract.

---

### 1
This smart contract is the game of TicTacToe with gambling aspects.

- Both players must send the required amount of money to be able to play.
- The second player starts the game and chooses in which cell he wants to put his sign.
- The first player (contract owner) puts his sign after the second's players turn.
- Repeat steps 2 - 3 until the winner is announced or the board is full.
- If there is winner in the game, he automaticly gets all the money of the prize pool, if game ended as a draw, both players gets their paid money back.

---

### 2
For contract implementation was used website `https://remix.ethereum.org/`

---

### 3

- For testing on LAN was used `JavaScript VM (London)` that is provided by `https://remix.ethereum.org/`
- For testing on Ethereum test network was used `MetaMask Ropsten Test Network` that you can download from `https://metamask.io/download`

---

### 4

The contract was amazing

---

### 5 

The front-end was implemented with JavaScript and `Web3.js` library