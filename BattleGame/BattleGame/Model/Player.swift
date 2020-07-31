//
//  Player.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

final class Player {
    
    // MARK: - Properties
    
    // List of players
    static var list = [Player]()
    
    var name: String
    var characters = [Character]()
    
    // MARK: - Initializer
    
    init(name: String) {
        self.name = name
    }
    
    // MARK: - Public method
    
    // Creation of team for each player
    func createTeam(withCharacters charactersList: [Character]) {
        for character in charactersList {
            characters.append(character)
        }
    }
}
