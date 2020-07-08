//
//  Character.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

protocol Character {
    var name: String { get set }
    var image: String { get set }
    var lifePoint: Int { get set }
    var heal: Bool { get set }
    var weapon: Weapon { get set }
    func heal(target: Character) -> Int
    func attack(target: Character) -> Int
}

extension Character {
    func heal(target: Character) -> Int {
        let lifePoints = target.lifePoint + weapon.healPoint
        return lifePoints
    }
    
    func attack(target: Character) -> Int {
        let lifePoints = target.lifePoint - weapon.damagePoint
        return lifePoints
    }
}
