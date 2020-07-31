//
//  Chest.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

final class Chest {
    
    // MARK: - Properties
    
    var randomTurn: Int!
    var randomPlayer: Int!
    var randomCharacter: Int!
    
    // MARK: - Public methods
    
    // The part of random
    func isTheChestOpen() -> Weapon? {
        if randomTurn <= 2 {
            let randomWeapon = Weapon.list.randomElement()
            if let weapon = randomWeapon {
                return weapon
            }
        }
        return nil
    }
    
    // Random assignation of weapon
    func assignate(_ weapon: Weapon) {
        randomPlayer = haveRandomPlayer()
        randomCharacter = haveRandomCharacter()
        if Player.list[randomPlayer].characters[randomCharacter].lifePoint > 0 {
            Player.list[randomPlayer].characters[randomCharacter].weapon = weapon
        } else {
            assignate(weapon)
        }
    }
    
    // Have random turn
    func haveRandomTurn() -> Int {
        return Int.random(in: 0...10)
    }
    
    // Have random player
    private func haveRandomPlayer() -> Int {
        return Int.random(in: 0...1)
    }
    
    // Have random character
    private func haveRandomCharacter() -> Int {
        return Int.random(in: 0...2)
    }
}
