//
//  Race.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

final class Ork: Character {
    
    // MARK: - Properties
    
    var name: String
    var lifePoint = 15
    var canHeal = false
    var canAttack = true
    var image = "ork"
    var weapon = Weapon.list[0] {
        didSet {
            if self.weapon.healPoint > 0 { self.canHeal = true } else { self.canHeal = false }
            if self.weapon.damagePoint > 0 { self.canAttack = true } else { self.canAttack = false }
        }
    }
    
    // MARK: - Initializer
    
    init(_ name: String) {
        self.name = name
    }
}

final class Knight: Character {
    
    // MARK: - Properties
    
    var name: String
    var lifePoint = 10
    var canHeal = false
    var canAttack = true
    var image = "knight"
    var weapon = Weapon.list[1] {
        didSet {
            if self.weapon.healPoint > 0 { self.canHeal = true } else { self.canHeal = false }
            if self.weapon.damagePoint > 0 { self.canAttack = true } else { self.canAttack = false }
        }
    }
    
    // MARK: - Initializer
    
    init(_ name: String) {
        self.name = name
    }
}

final class Wizard: Character {
    
    // MARK: - Properties
    
    var name: String
    var lifePoint = 12
    var canHeal = true
    var canAttack = true
    var image = "wizard"
    var weapon = Weapon.list[2] {
        didSet {
            if self.weapon.healPoint > 0 { self.canHeal = true } else { self.canHeal = false }
            if self.weapon.damagePoint > 0 { self.canAttack = true } else { self.canAttack = false }
        }
    }
    
    // MARK: - Initializer
    
    init(_ name: String) {
        self.name = name
    }
}
