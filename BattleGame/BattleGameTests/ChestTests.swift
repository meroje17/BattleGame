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
        let weapon = chest.isTheChestOpen()
        XCTAssertTrue(weapon != nil)
    }
    
    func testOpenToGetWeapon_WhenTurnIsOver1_ChestReturnAWeapon() {
        let chest = Chest()
        chest.randomTurn = 9
        let weapon = chest.isTheChestOpen()
        XCTAssertTrue(weapon == nil)
    }
    
    func testAssignate_WhenItsOK_ShouldHaveDifferentRandomItemFilled() {
        let players: [Player] = [Player(name: "Test1"), Player(name: "Test2")]
        let characters: [Character] = [Ork("ORKI"), Wizard("WIZZI"), Knight("Knight")]
        Player.list = players
        Player.list[0].characters = characters
        Player.list[1].characters = characters
        let chest = Chest()
        chest.randomTurn = 1
        let weapon = chest.isTheChestOpen()
        chest.assignate(weapon!)
        XCTAssertTrue(chest.randomPlayer != nil)
        XCTAssertTrue(chest.randomPlayer >= 0 && chest.randomTurn <= 1)
        XCTAssertTrue(chest.randomCharacter != nil)
        XCTAssertTrue(chest.randomCharacter >= 0 && chest.randomTurn <= 2)
        Player.list = [Player]()
    }
    
    func testRandomInt_WhenItsOK_ShouldBeReturnAnInt() {
        let chest = Chest()
        let int = chest.haveRandomTurn()
        XCTAssertTrue(int >= 0 && int <= 10)
    }
}
