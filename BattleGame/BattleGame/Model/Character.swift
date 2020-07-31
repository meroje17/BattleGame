//
//  Character.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

// MARK: - Protocol character with all theirs properties and methods

protocol Character {

    // MARK: - Properties
    
    var name: String { get set }
    var image: String { get set }
    var lifePoint: Int { get set }
    var canHeal: Bool { get set }
    var canAttack: Bool { get set }
    var weapon: Weapon { get set }
    
    // MARK: - Methods
    
    func heal(target: Character) -> Int
    func attack(target: Character) -> Int
}

// MARK: - Extension to init methods

// Init protocol with extension for character possible actions
extension Character {
    
    // Heal one character
    func heal(target: Character) -> Int {
        let lifePoints = target.lifePoint + weapon.healPoint
        return lifePoints
    }
    
    // Attack one character
    func attack(target: Character) -> Int {
        let lifePoints = target.lifePoint - weapon.damagePoint
        return lifePoints
    }
}
