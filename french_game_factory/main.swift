//
//  main.swift
//  french_game_factory
//
//  Created by Hugo Blas on 24/08/2023.
//

import Foundation

print("""
Welcome in our new game !
We are starting now !

Please enter the number of players
""")

var numberOfPlayer: Int = 0

while numberOfPlayer == 0 {
    if let numberOfPlayers = Int(readLine() ?? "") {
        numberOfPlayer = numberOfPlayers
    } else {
        print("Please enter a number over 0")
    }
}

print("Enter the number of characters per player")

var numberOfCharacter: Int = 0

while numberOfCharacter == 0 {
    if let numberOfCharacters = Int(readLine() ?? "") {
        numberOfCharacter = numberOfCharacters
    } else {
        print("Please enter a number over 0")
    }
}

// Game initialization with the parameter entered by the user
let game: Game = Game(numberOfPlayers: numberOfPlayer, numberOfCharacters: numberOfCharacter)

while game.shouldContinuePlaying {
    // While multiple players have alive characters we can play
    game.playRound()
}

// Once there is only 1 player with a character thats alive we display the end game message
print("""
WE HAVE A WINNER !
Congrats \(game.lastPlayerAlive!.name)
You Win !
""")
