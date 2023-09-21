//
//  Game.swift
//  french_game_factory
//
//  Created by Hugo Blas on 25/08/2023.
//

import Foundation

class Game {

    var players: [Player] = []

    var rounds: Int = 0

    init(numberOfPlayers: Int, numberOfCharacters: Int) {
        initGame(numberOfCharacters: numberOfCharacters, numberOfPlayers: numberOfPlayers)
    }

    fileprivate func doAction(index: Int, otherPlayer: Player,  character: Character, player: Player) {
        let isHeal: Bool = index == 2 && character is Magus
        if index == 1 {
            // If selected action is attack, display other player characters
            print("Select which character you want to attack")
            var i = 0
            while (i < otherPlayer.characters.count) {
                let char: Character = otherPlayer.characters[i]
                print("\(char.name), \(char.type.string), \(char.healthPoints)HP : \(i+1)")
                i += 1
            }
        } else if isHeal {
            // If selected action is heal, display current player characters
            print("Select which character you want to heal")
            var i = 0
            while (i < otherPlayer.characters.count) {
                let char: Character = player.characters[i]
                print("\(char.name), \(char.type.string), \(char.healthPoints)HP : \(i+1)")
                i += 1
            }
        }

        if let selectedChar = Int(readLine() ?? "") {
            if isHeal {
                player.characters[selectedChar-1].heal(pointsToHeal: character.weapon.heal)
                print("\(character.name) healed \(player.characters[selectedChar-1].name) of \(character.weapon.heal) HP")
                return
            }
            otherPlayer.characters[selectedChar-1].takeDamage(damage: character.weapon.damage)
            print("\(character.name) attacked \(otherPlayer.characters[selectedChar-1].name) and take out \(character.weapon.damage) HP")
            return ;
        }
    }

    /// Play a round of the game
    func playRound() {
        rounds += 1
        // loop through players
        var i: Int = 0
        while i < players.count {
            let player: Player = players[i]
            print("\(player.name)'s turn")
            let otherPlayers: [Player] = players.filter { $0.uuid != player.uuid }
            // choose character

            let character: Character = selectCharacter(player: player)
            // choose action if possible
            print("""
        Select an action
        Attack: 1
        """)
            if character is Magus {
                print("Heal: 2")
            }
            if let index = Int(readLine() ?? "") {
                print("Choose a player")
                var i: Int = 1
                for player in otherPlayers {
                    print("\(i): \(player.name)")
                    i += 1
                }
                if let otherPlayerIndex = Int(readLine() ?? "") {
                    if otherPlayerIndex - 1 >= 0 && otherPlayerIndex - 1 < otherPlayers.count {
                        doAction(index: index, otherPlayer: otherPlayers[otherPlayerIndex - 1], character: character, player: player)
                    } else {
                        continue
                    }
                } else {
                    continue
                }
            } else {
                continue
            }
            i += 1
        }

        // Display current battle state
        var playersChar: [String] = [];

        for player in players {
            playersChar.append("\(player.name):")
            var i = 0
            while (i < player.characters.count) {
                let char: Character = player.characters[i]
                playersChar.append("\(char.name), \(char.type.string), \(char.healthPoints)HP : \(i+1)")
                i += 1
            }
        }

        print("""
            End of round n°\(rounds)

            \(playersChar)
            """)
    }

    /// Returns a `Character` selected by `player`
    fileprivate func selectCharacter(player: Player) -> Character {
        print("Choose a character")
        var i: Int = 1
        for char in player.characters {
            print("\(i): \(char.name) / HP: \(char.healthPoints)")
            i += 1
        }
        if let index = Int(readLine() ?? ""){
            let character: Character? = player.chooseCharacter(index: index - 1)
            if let char = character {
                return char
            }
        }
        print("Wrong entry, please select a number between 1 and \(player.characters.count)")
        return selectCharacter(player: player)
    }

    fileprivate func initPlayers(numberOfPlayers: Int) -> Void {
        while players.count < numberOfPlayers {
            print("""
            Player \(players.count + 1)
            Please type your name.
            """)
            if let name = readLine() {
                print("Player \(players.count + 1): \(name)")
                players.append(Player(name: name))
            }
        }
    }

    fileprivate func initGame(numberOfCharacters: Int, numberOfPlayers: Int) {
        initPlayers(numberOfPlayers: numberOfPlayers)
        for player in players {
            print("\(player.name) choose your characters: ")
            while player.characters.count < numberOfCharacters {
                print("What type of character do you want to choose ?");
                print("""
                    Warrior: 1
                    Dwarf: 2
                    Magus: 3
                    """);
                let index: String? = readLine()
                if let unwrappedIndex = index {
                    let index: Int = Int(unwrappedIndex) ?? 4
                    if index > 3 {
                        print("Entry not valid");
                        continue
                    }
                    print("Enter your new characters name: ")
                    let name: String? = readLine()
                    if let unwrappedName = name {
                        let character: Character;
                        switch CharacterType.characterTypes[index-1] {
                        case CharacterType.warrior:
                            character = Warrior(name: unwrappedName)

                        case CharacterType.dwarf:
                            character = Dwarf(name: unwrappedName)

                        case CharacterType.magus:
                            character = Magus(name: unwrappedName)
                        }
                        player.addCharacter(character: character)
                    }
                }
            }
        }
        print("Game is now starting !")
        print("First round !")
    }

    var shouldContinuePlaying: Bool {
        for player in players {
            if player.numberOfAliveCharacters == 0 {
                return false
            }
        }
        return true
    }

    var lastPlayerAlive: Player? {
        for player in players {
            if player.numberOfAliveCharacters != 0 {
                return player
            }
        }
        return nil
    }
}
