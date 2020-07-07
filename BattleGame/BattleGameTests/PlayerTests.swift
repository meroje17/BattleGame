//
//  PlayerTests.swift
//  BattleGameTests
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import XCTest
@testable import BattleGame

final class PlayerTests: XCTestCase {
    func testInitPlayer_WhenEveryThingIsOK_ShouldHavePlayerFilled() {
        let player = Player(name: "Jérôme Guèrin")
        XCTAssertTrue(player.name == "Jérôme Guèrin")
        XCTAssertTrue(player.characters.count == 0)
        XCTAssertTrue(Player.list.count == 0)
    }
    
    func testInitPlayerAndAddInPlayerList_WhenEveryThingIsOK_ShouldHavePlayerAndListFilled() {
        let player = Player(name: "Jérôme Guèrin")
        Player.list.append(player)
        XCTAssertTrue(player.name == "Jérôme Guèrin")
        XCTAssertTrue(player.characters.count == 0)
        XCTAssertTrue(Player.list.count == 1)
    }
    
    func testCreateTeam_WhenEveryThingIsOK_ShouldHaveTeamOfPlayerFilled() {
        let player = Player(name: "Jérôme Guèrin")
        let characters: [Character] = [Ork("ORKI"), Knight("KNOCKI"), Wizard("WIZZI")]
        player.createTeam(withCharacters: characters)
        XCTAssertTrue(player.name == "Jérôme Guèrin")
        XCTAssertTrue(player.characters.count == 3)
        XCTAssertTrue(player.characters[0].name == "ORKI")
        XCTAssertTrue(player.characters[1].name == "KNOCKI")
        XCTAssertTrue(player.characters[2].name == "WIZZI")
    }
}
