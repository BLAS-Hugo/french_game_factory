//
//  CharacterManager.swift
//  french_game_factory
//
//  Created by Hugo Blas on 19/10/2023.
//

import Foundation

class CharacterManager {
    static var characterNames: [String] = []

    static func contains(_ other: String) -> Bool {
        return characterNames.contains(other)
    }
}
