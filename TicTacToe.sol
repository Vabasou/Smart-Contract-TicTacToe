// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract TicTacToe {

    address public player1;
    address public player2;

    uint8 current_move = 0;

    enum CellState {Empty, X, O}
    CellState[9] board;

    uint[][] winningCombinations = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]];

    uint public stakes;
    uint public prizePool = 0;

    // Board
    // 0 1 2
    // 3 4 5
    // 6 7 8

    mapping (address => bool) public isPaid;

    constructor(address _player2, uint _stakes) {
        require(_player2 != msg.sender);
        player1 = msg.sender;
        player2 = _player2;
        stakes = _stakes;
    }

    function player1Address() public view returns(address) {
        return player1;
    }

    function player2Address() public view returns(address) {
        return player2;
    }

    receive() payable external{
        require(msg.value == stakes, "Wrong amount of money");
        prizePool += msg.value;
        isPaid[msg.sender] = true;
    }

    // 10000000000000000
    function withdraw() external payable {
        // require(isPaid[msg.sender] == true, "You already withdrew your money");
        if (winner() == 0x0000000000000000000000000000000000000000 && current_move > 8) {
            payable(player1).transfer(stakes);
            payable(player2).transfer(stakes);
        } else
            payable(msg.sender).transfer(prizePool);
    
        isPaid[player1] = false;
        isPaid[player2] = false;

        prizePool = 0;
    }

    function rowToString() public view returns (string memory) {
        return string(abi.encodePacked(cellToString(0), "|", cellToString(1), "|", cellToString(2), "|", cellToString(3), "|", cellToString(4), "|",
        cellToString(5), "|", cellToString(6), "|", cellToString(7), "|", cellToString(8)));
    }

    function performMove(uint8 cellID) public {
        // require(isPaid[msg.sender] == true, "pay the price");
        // require(msg.sender == player1 || msg.sender == player2);
        // require(!isGameOver());
        // require(msg.sender == currentPlayerAddress());

        // require(positionIsInBounds(cellID), "Choose valid cell number");
        // require(board[cellID] == CellState.Empty);

        board[cellID] = currentPlayerShape();
        current_move = current_move + 1;
    }

    function currentPlayerAddress() public view returns (address) {
        if (current_move % 2 == 0) {
            return player2;
        } else {
            return player1;
        }
    }

    function currentPlayerShape() private view returns (CellState) {
        if (current_move % 2 == 0) {
            return CellState.X;
        } else {
            return CellState.O;
        }
    }

    function winner() public view returns(address) {
        CellState winning_shape = checkWinner();
        if (winning_shape == CellState.X) {
            return player2;
        } else if (winning_shape == CellState.O) {
            return player1;
        }
    }

    function isGameOver() public view returns (bool) {
        return (checkWinner() != CellState.Empty || current_move > 8);
    }

    function checkWinner() private view returns (CellState) {
        for(uint8 i = 0; i < winningCombinations.length; i++) {
            uint[] memory combination = winningCombinations[i];
            if (board[combination[0]] != CellState.Empty && board[combination[0]] == board[combination[1]] && board[combination[0]] == board[combination[2]]) {
                return board[combination[0]];
            }
        }
        
        return CellState.Empty;
    }

    function cellToString(uint8 cellID) private view returns (string memory) {
        require (positionIsInBounds(cellID), "Choose valid cell number");

        if (board[cellID] == CellState.Empty) {
            return " ";
        }
        if (board[cellID] == CellState.X) {
            return "X";
        }
        if (board[cellID] == CellState.O) {
            return "O";
        }
    }

    function positionIsInBounds(uint8 cellID) private pure returns (bool) {
        return (cellID >= 0 && cellID < 9);
    }
}