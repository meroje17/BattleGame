//
//  CharacterTests.swift
//  BattleGameTests
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import XCTest
@testable import BattleGame

class CharacterTests: XCTestCase {
    func testHealMethod_WhenEverythingItsOK_ShouldReturnGoodInt() {
        let playerOne = Ork("ORKI")
        let playerTwo = Wizard("WIZZI")
        playerOne.lifePoint = 2
        playerOne.lifePoint = playerTwo.heal(target: playerOne)
        XCTAssertTrue(playerOne.lifePoint == 3)
    }
    
    func testAttackMethod_WhenEverythingItsOK_ShouldReturnGoodInt() {
        let playerOne = Ork("ORKI")
        let playerTwo = Wizard("WIZZI")
        playerTwo.lifePoint = playerOne.attack(target: playerTwo)
        XCTAssertTrue(playerTwo.lifePoint == 11)
    }
}
