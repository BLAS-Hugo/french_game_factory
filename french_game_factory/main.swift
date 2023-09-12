//
//  main.swift
//  french_game_factory
//
//  Created by Hugo Blas on 24/08/2023.
//

import Foundation

let game: Game = Game()

game.initGame(numberOfCharacters: 3)

while game.players[0].numberOfAliveCharacters > 0 || game.players[1].numberOfAliveCharacters > 0 {
    // We can play
    game.playRound()
}

// END GAME
