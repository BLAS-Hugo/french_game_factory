//
//  Game.swift
//  french_game_factory
//
//  Created by Hugo Blas on 25/08/2023.
//

import Foundation

class Game {

    private var players: [Player] = []

    private var rounds: Int = 0

    init(numberOfPlayers: Int, numberOfCharacters: Int) {
        initGame(numberOfCharacters: numberOfCharacters, numberOfPlayers: numberOfPlayers)
    }

    /// The player can select the character to execute the action on and then do the specified action
    private func doAction(index: Int, otherPlayer: Player,  character: Character, player: Player) -> Void {
        let isHeal: Bool = index == 2 && character is Magus
        if index == 1 {
            // If selected action is attack, display other player characters
            print("Select which character you want to attack")
            var i = 0
            while (i < otherPlayer.characters.count) {
                let char: Character = otherPlayer.characters[i]
                var hp: Int = char.healthPoints
                if hp < 0 {
                    hp = 0
                }
                print("\(char.name), \(char.type.string), \(hp)HP : \(i+1)")
                i += 1
            }
        } else if isHeal {
            // If selected action is heal, display current player characters
            print("Select which character you want to heal")
            var i = 0
            while (i < player.characters.count) {
                let char: Character = player.characters[i]
                var hp: Int = char.healthPoints
                if hp < 0 {
                    hp = 0
                }
                print("\(char.name), \(char.type.string), \(hp)HP : \(i+1)")
                i += 1
            }
        }

        if let selectedChar = Int(readLine() ?? "") {
            if isHeal {
                if player.characters[selectedChar-1].healthPoints <= 0 {
                    print("""

                This character is already dead

                """)
                    doAction(index: index, otherPlayer: otherPlayer,  character: character, player: player)
                    return
                }
                player.characters[selectedChar-1].heal(pointsToHeal: character.weapon.heal)
                print("\(character.name) healed \(player.characters[selectedChar-1].name) of \(character.weapon.heal) HP")
                return
            }
            if otherPlayer.characters[selectedChar-1].healthPoints <= 0 {
                print("""

            This character is already dead

            """)
                doAction(index: index, otherPlayer: otherPlayer,  character: character, player: player)
                return
            }
            otherPlayer.characters[selectedChar-1].takeDamage(damage: character.weapon.damage)
            print("\(character.name) attacked \(otherPlayer.characters[selectedChar-1].name) and take out \(character.weapon.damage) HP")
            return
        }
    }

    /// Play a round of the game
    /// Loops through the players array and make the player select the character they want to use,
    /// the action they want to execute,
    /// the player they want to attack
    /// Then this fucntion calls the doAction function
    /// And displays the state of the game
    func playRound() -> Void {
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
                if index == 2 {
                    doAction(index: index, otherPlayer: player, character: character, player: player)
                    i += 1
                } else {
                    print("Choose a player")
                    var j: Int = 1
                    for player in otherPlayers {
                        print("\(j): \(player.name)")
                        j += 1
                    }
                    if let otherPlayerIndex = Int(readLine() ?? "") {
                        if otherPlayerIndex - 1 >= 0 && otherPlayerIndex - 1 < otherPlayers.count {
                            doAction(index: index, otherPlayer: otherPlayers[otherPlayerIndex - 1], character: character, player: player)
                            i += 1
                        }
                    }
                }
            }
        }

        // Display current battle state
        var playersChar: [String] = [];

        for player in players {
            playersChar.append("\(player.name):")
            var i = 0
            while (i < player.characters.count) {
                let char: Character = player.characters[i]
                var hp: Int = char.healthPoints
                if hp < 0 {
                    hp = 0
                }
                playersChar.append("\(char.name), \(char.type.string), \(hp)HP : \(i+1)")
                i += 1
            }
        }

        print("""

            End of round n°\(rounds)

            """)
        for player in playersChar {
            print(player)
        }
    }

    /// Returns a `Character` selected by `player`
    private func selectCharacter(player: Player) -> Character {
        print("""

            Choose a character

            """)

        var i: Int = 1
        for char in player.characters {
            var hp: Int = char.healthPoints
            if hp < 0 {
                hp = 0
            }
            print("\(i): \(char.name) / HP: \(hp)")
            i += 1
        }
        if let index = Int(readLine() ?? ""){
            let character: Character? = player.chooseCharacter(index: index - 1)
            if let char = character {
                if char.healthPoints <= 0 {
                    print("This character has 0 HP, he is not able to fight anymore")
                    return selectCharacter(player: player)
                }
                return char
            }
        }
        print("Wrong entry, please select a number between 1 and \(player.characters.count)")
        return selectCharacter(player: player)
    }

    /// Initialize the players array
    /// While the number of players specified in parameters are not added
    /// It creates a new Player with the name specified by the user
    private func initPlayers(numberOfPlayers: Int) -> Void {
        while players.count < numberOfPlayers {
            print("""

            Player \(players.count + 1)
            Please type your name.
            """)
            if let name = readLine() {
                print("""
                Player \(players.count + 1): \(name)

                """)
                players.append(Player(name: name))
            }
        }
    }

    /// Calls the initPlayers function to initialize the players array
    /// Then  add new character for each player until the specified number is reached
    /// Then start the game
    private func initGame(numberOfCharacters: Int, numberOfPlayers: Int) -> Void {
        initPlayers(numberOfPlayers: numberOfPlayers)
        for player in players {
            print("""

                \(player.name) choose your characters:

                """)
            while player.characters.count < numberOfCharacters {
                print("What type of character do you want to choose ?");
                print("""
                    Warrior: 1
                    Dwarf: 2
                    Magus: 3

                    """);
                if let index = Int(readLine() ?? "") {
                    if index > 3 {
                        print("Entry not valid");
                        continue
                    }
                    print("Enter your new characters name: ")

                    if let name = readLine() {
                        if CharacterManager.contains(name) {
                            print("This character name already exists, please enter a different one")
                            continue
                        }
                        let character: Character;
                        switch CharacterType.characterTypes[index-1] {
                        case CharacterType.warrior:
                            character = Warrior(name: name)

                        case CharacterType.dwarf:
                            character = Dwarf(name: name)

                        case CharacterType.magus:
                            character = Magus(name: name)
                        }
                        player.addCharacter(character: character)
                        CharacterManager.characterNames.append(name)
                    }
                } else {
                    print("Entry not valid");
                    continue
                }
            }
        }
        print("""

        Game is now starting !
        """)
        print("""
        First round !

        """)
    }

    /// Returns True if at least 2 players have a character alive
    var shouldContinuePlaying: Bool {
        let playersInGame: [Player] = players.filter { $0.numberOfAliveCharacters > 0 }
        return playersInGame.count > 1
    }

    /// Returns the last player with at least 1 character alive
    var lastPlayerAlive: Player? {
        for player in players {
            if player.numberOfAliveCharacters != 0 {
                return player
            }
        }
        return nil
    }
}
