//
//  Chest.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

final class Chest {
    var randomTurn: Int!
    var randomPlayer: Int!
    var randomCharacter: Int!
    
    func isTheChestOpen() -> Weapon? {
        if randomTurn <= 2 {
            let randomWeapon = Weapon.list.randomElement()
            if let weapon = randomWeapon {
                return weapon
            }
        }
        return nil
    }
    
    func assignate(_ weapon: Weapon) {
        randomPlayer = haveRandomPlayer()
        randomCharacter = haveRandomCharacter()
        if Player.list[randomPlayer].characters[randomCharacter].lifePoint > 0 {
            Player.list[randomPlayer].characters[randomCharacter].weapon = weapon
        } else {
            assignate(weapon)
        }
    }
    
    func haveRandomTurn() -> Int {
        return Int.random(in: 0...10)
    }
    
    private func haveRandomPlayer() -> Int {
        return Int.random(in: 0...1)
    }
    
    private func haveRandomCharacter() -> Int {
        return Int.random(in: 0...2)
    }
}
