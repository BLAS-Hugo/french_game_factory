//
//  Character.swift
//  french_game_factory
//
//  Created by Hugo Blas on 25/08/2023.
//

import Foundation

protocol Character {

    var name: String { get set }

    var healthPoints: Int { get set }

    var weapon: Weapon { get }
    
    func toString() -> String

    func takeDamage(damage: Int)

    func heal(pointsToHeal: Int)
}
