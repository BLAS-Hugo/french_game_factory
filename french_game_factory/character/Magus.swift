//
//  Magus.swift
//  french_game_factory
//
//  Created by Hugo Blas on 25/08/2023.
//

import Foundation

public class Magus: Character {

    var name: String
    var healthPoints: Int
    var weapon: Weapon

    init(name: String) {
        self.name = name
        healthPoints = 50
        weapon = Weapon(weaponType: WeaponType.staff)
    }

    func takeDamage(damage: Int) {
        healthPoints -= damage
    }

    func heal(pointsToHeal: Int) {
        healthPoints += pointsToHeal
    }
}
