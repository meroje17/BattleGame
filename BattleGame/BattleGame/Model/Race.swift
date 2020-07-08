//
//  Race.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

final class Ork: Character {
    var name: String
    var lifePoint = 15
    var heal = false
    var image = "ork"
    var weapon = Weapon.list[0] {
        didSet {
            if self.weapon.healPoint > 0 { self.heal = true } else { self.heal = false }
        }
    }
    
    init(_ name: String) {
        self.name = name
    }
}

final class Knight: Character {
    var name: String
    var lifePoint = 10
    var heal = false
    var image = "knight"
    var weapon = Weapon.list[1] {
        didSet {
            if self.weapon.healPoint > 0 { self.heal = true } else { self.heal = false }
        }
    }
    
    init(_ name: String) {
        self.name = name
    }
}

final class Wizard: Character {
    var name: String
    var lifePoint = 12
    var heal = true
    var image = "wizard"
    var weapon = Weapon.list[2] {
        didSet {
            if self.weapon.healPoint > 0 { self.heal = true } else { self.heal = false }
        }
    }
    
    init(_ name: String) {
        self.name = name
    }
}
