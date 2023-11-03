//
//  Character.swift
//  french_game_factory
//
//  Created by Hugo Blas on 25/08/2023.
//

import Foundation

protocol Character {

    var name: String { get set }

    var type: CharacterType { get }

    var healthPoints: Int { get set }

    var weapon: Weapon { get }

}

extension Character  {

    mutating func takeDamage(damage: Int) {
        healthPoints -= damage
        if healthPoints <= 0 {
            print("""

                \(name) has 0 HP, he died
                
                """)
        }
    }

    mutating func heal(pointsToHeal: Int) {
        healthPoints += pointsToHeal
    }
}

enum CharacterType {
    case warrior, dwarf, magus;

    static let characterTypes: [CharacterType] = [CharacterType.warrior, CharacterType.dwarf, CharacterType.magus]

    var string: String {
        switch self {
        case .warrior:
            return "Warrior"
        case .dwarf:
            return "Dwarf"
        case .magus:
            return "Magus"
        }
    }
}
