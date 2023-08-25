//
//  Game.swift
//  french_game_factory
//
//  Created by Hugo Blas on 25/08/2023.
//

import Foundation

public class Game {

    var players: [Player]

    var rounds: Int

    init(players: [Player]) {
        self.players = players
        rounds = 0
    }

    func playRound() {
        // loop through players
        for player in players {
            // choose character
            let character: Character = selectCharacter(player: player)
            print(character.toString())

            // choose action if possible

            // choose character to apply action to

        }
    }

    func selectCharacter(player: Player) -> Character {
        print("Choose a character")

        let index: String? = readLine()
        if let unwrapped = index {
            let character: Character? = player.chooseCharacter(index: ((Int(unwrapped) ?? 100) - 1))
            if let char = character {
                print(char.toString())
                return char
            } else {
                print("Wrong entry, please select a number between 1 and \(player.characters.count)")
                return selectCharacter(player: player)
            }
        } else {
            print("Wrong entry, please select a number between 1 and \(player.characters.count)")
            return selectCharacter(player: player)
        }
    }

}
