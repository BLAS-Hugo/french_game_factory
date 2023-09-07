//
//  Game.swift
//  french_game_factory
//
//  Created by Hugo Blas on 25/08/2023.
//

import Foundation

class Game {

    var players: [Player]

    var rounds: Int = 0

    init(players: [Player]) {
        self.players = players
    }

    /// Play a round of the game
    func playRound() {
        // loop through players
        for player in players {
            // choose character
            let character: Character = selectCharacter(player: player)
            print(character)

            // choose action if possible

            // choose character to apply action to

        }
    }

    /// Returns a `Character` selected by `player`
    func selectCharacter(player: Player) -> Character {
        print("Choose a character")

        let index: String? = readLine()
        if let unwrapped = index {
            let character: Character? = player.chooseCharacter(index: ((Int(unwrapped) ?? 100) - 1))
            if let char = character {
                print(char)
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

    func initGame() {
        print("""
        Welcome in our new game !
        We are starting now !
        Please select your characters
        """)
        for player in players {
            while player.characters.count < 3 {
                print("What type of character do you want to choose ?");
                print("""
                    Warrior: 1
                    Dwarf: 2
                    Magus: 3
                    """);
                let index: String? = readLine()
                if let unwrappedIndex = index {
                    print("Enter your new characters name: ")
                    let name: String? = readLine()
                    if let unwrappedName = name {
                        let character: Character;
                        switch unwrappedIndex {
                        case "1":
                            character = Warrior(name: unwrappedName)
                            break
                        case "2":
                            character = Dwarf(name: unwrappedName)
                            break
                        case "3":
                            character = Magus(name: unwrappedName)
                            break
                        default:
                            print("Entry not valid");
                            continue
                        }
                        player.addCharacter(character: character)
                    }
                }
            }
        }
        print("Game is now starting !")
        print("First round !")
        print(players[0].characters)
        print(players[1].characters)
    }
}
