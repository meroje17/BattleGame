//
//  Chest.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

protocol Random {
    var randomTurn: Int! { get set }
    func openToGetWeapon() -> Weapon?
    func randomInt() -> Int
}

final class Chest: Random {
    var randomTurn: Int!
    
    func openToGetWeapon() -> Weapon? {
        randomTurn = randomInt()
        if randomTurn <= 2 {
            let randomWeapon = Weapon.list.randomElement()
            if let weapon = randomWeapon {
                return weapon
            }
        }
        return nil
    }
    
    func randomInt() -> Int {
        return Int.random(in: 0...10)
    }
}
