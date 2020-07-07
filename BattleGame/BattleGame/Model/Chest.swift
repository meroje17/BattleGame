//
//  Chest.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

final class Chest {
    var randomTurn = Int.random(in: 0...10)
    
    func openToGetWeapon() -> Weapon? {        
        if randomTurn <= 1 {
            let randomWeapon = Weapon.list.randomElement()
            if let weapon = randomWeapon {
                return weapon
            }
        }
        return nil
    }
}
