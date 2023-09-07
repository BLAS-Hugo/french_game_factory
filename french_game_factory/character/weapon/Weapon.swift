//
//  Weapon.swift
//  french_game_factory
//
//  Created by Hugo Blas on 25/08/2023.
//

import Foundation

class Weapon {

    let weaponType: WeaponType

    init(weaponType: WeaponType) {
        self.weaponType = weaponType
    }
}

enum WeaponType {
    case sword, axe, staff

    var damage: Int {
        switch self {
        case .sword:
            return 10
        case .axe:
            return 20
        case .staff:
            return 5
        }
    }

    var heal: Int {
        switch self {
        case .sword:
            return 0
        case .axe:
            return 0
        case .staff:
            return 10
        }
    }
}
