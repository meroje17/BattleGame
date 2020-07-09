//
//  ChestTests.swift
//  BattleGameTests
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import XCTest
@testable import BattleGame


class ChestTests: XCTestCase {
    func testOpenToGetWeapon_WhenTurnIsUnder1_ChestReturnAWeapon() {
        let chest = Chest()
        chest.randomTurn = 0
        let weapon = chest.openToGetWeapon()
        XCTAssertTrue(weapon != nil)
    }
    
    func testOpenToGetWeapon_WhenTurnIsOver1_ChestReturnAWeapon() {
        let chest = Chest()
        chest.randomTurn = 5
        let weapon = chest.openToGetWeapon()
        XCTAssertTrue(weapon == nil)
    }
    
    func testRandomInt_WhenItsOK_ShouldBeReturnAnInt() {
        let chest = Chest()
        chest.randomTurn = chest.randomInt()
        XCTAssertTrue(chest.randomTurn != nil)
        XCTAssertTrue(chest.randomTurn >= 0 && chest.randomTurn <= 10)
        
    }
}
