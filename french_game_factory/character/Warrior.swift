//
//  Warrior.swift
//  french_game_factory
//
//  Created by Hugo Blas on 25/08/2023.
//

import Foundation

public class Warrior: Character {

    var name: String
    var healthPoints: Int
    var weapon: Weapon

    init(name: String) {
        self.name = name
        healthPoints = 100
        weapon = Weapon(weaponType: WeaponType.sword)
    }

    func takeDamage(damage: Int) {
        healthPoints -= damage
    }

    func heal(pointsToHeal: Int) {
        healthPoints += pointsToHeal
    }

    func toString() -> String {
        return "Instance of Warrior : name: \(name) / HP: \(healthPoints)"
    }

}
