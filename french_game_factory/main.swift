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
        break
    }
    print("Please enter a number over 0")
    continue
}

print("Enter the number of characters per player")

var numberOfCharacter: Int = 0

while numberOfCharacter == 0 {
    if let numberOfCharacters = Int(readLine() ?? "") {
        numberOfCharacter = numberOfCharacters
        break
    }
    print("Please enter a number over 0")
    continue
}

let game: Game = Game(numberOfPlayers: numberOfPlayer, numberOfCharacters: numberOfCharacter)

while game.shouldContinuePlaying {
    // We can play
    game.playRound()
}

// END GAME
print("""
WE HAVE A WINNER !
Congrats \(game.lastPlayerAlive!.name)
You Win !
""")
