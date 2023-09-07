//
//  main.swift
//  french_game_factory
//
//  Created by Hugo Blas on 24/08/2023.
//

import Foundation

let player1: Player = Player()
let player2: Player = Player()

let game: Game = Game(players: [player1, player2])

game.initGame()

while game.players[0].numberOfAliveCharacters > 0 || game.players[1].numberOfAliveCharacters > 0 {
    // We can play
    game.playRound()
}

// END GAME
