//
//  Weapon.swift
//  french_game_factory
//
//  Created by Hugo Blas on 25/08/2023.
//

import Foundation

class Weapon {

    let weaponType: WeaponType

    let damage: Int

    let heal: Int

    init(weaponType: WeaponType) {
        self.weaponType = weaponType
        switch self.weaponType {
            case WeaponType.sword:
                damage = 10
                heal = 0
            case WeaponType.axe:
                damage = 20
                heal = 0
            case WeaponType.staff:
                damage = 5
                heal = 10
        }
    }

}

enum WeaponType {
    case sword, axe, staff
}
