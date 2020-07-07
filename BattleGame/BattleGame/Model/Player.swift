//
//  Player.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

final class Player {
    static var list = [Player]()
    
    var name: String
    var characters = [Character]()
    
    init(name: String) {
        self.name = name
    }
    
    func createTeam(withCharacters charactersList: [Character]) {
        for character in charactersList {
            characters.append(character)
        }
    }
}
