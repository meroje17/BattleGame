//
//  Weapon.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

final class Weapon {
    static var list = [Weapon(name: "mace", damage: 1, heal: 0), Weapon(name: "sword", damage: 2, heal: 0), Weapon(name: "rod", damage: 0, heal: 1), Weapon(name: "ax", damage: 3, heal: 0), Weapon(name: "bandage", damage: 0, heal: 1), Weapon(name: "flower", damage: 0, heal: 1), Weapon(name: "gun", damage: 4, heal: 0), Weapon(name: "knife", damage: 1, heal: 0), Weapon(name: "machete", damage: 2, heal: 0), Weapon(name: "potion", damage: 0, heal: 2), Weapon(name: "power", damage: 5, heal: 3)]
    
    var nameOfWeapon: String
    var damagePoint: Int
    var healPoint: Int
    
    init(name: String, damage: Int, heal: Int) {
        self.nameOfWeapon = name
        self.damagePoint = damage
        self.healPoint = heal
    }
}
