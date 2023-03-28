// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract Players {
    
    struct Battle {
        Player player1;
        Player player2;
        uint256 betValue;
    }

    struct Ship {
        string[] shipPartCoordinate;
    }

    struct Player {
        string name;
        address playerAddress;
        Ship[] ships;
    }
    
    Player[] private players;
    Battle[] private battles;
    
    constructor()
    {

    }

    function addPlayer(string memory _name, Ship[] memory _ships) public {
        Player memory newPlayer = Player(_name, msg.sender, _ships);
        players.push(newPlayer);
    }
    
    function getBet(uint256  _betValue) private returns (Battle memory) 
    {
       uint battlesCount = battles.length;
        Battle memory battleReturn;
        for (uint i = 0; i < battlesCount; i++) {
            Battle memory battle = battles[i];
            if(battle.betValue == _betValue)
            {
                battleReturn = battle;
                break;
            }
        }        

        return battleReturn;
    }
    
}
