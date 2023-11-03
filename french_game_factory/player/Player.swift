//
//  Player.swift
//  french_game_factory
//
//  Created by Hugo Blas on 25/08/2023.
//

import Foundation

public class Player{
    var characters: [Character] = []
    let uuid: String
    let name: String

    init(name: String) {
        uuid = UUID().uuidString
        self.name = name
    }

    func addCharacter(character: Character) -> Void {
        characters.append(character)
    }

    /// Returs the number of character who have more than 0 healthPoints
    var numberOfAliveCharacters: Int {
        var numberOfAliveCharacters: Int = 0
        for char in characters {
            if char.healthPoints >= 0 {
                numberOfAliveCharacters += 1
            }
        }
        return numberOfAliveCharacters
    }

    /// Returns the `character` at the specified index from the `characters` list
    /// If the index is not valid, the user is notified and asked to give another number
    func chooseCharacter(index: Int) -> Character? {
        if index < characters.count && index >= 0 {
            return characters[index]
        }
        return nil
    }
}
