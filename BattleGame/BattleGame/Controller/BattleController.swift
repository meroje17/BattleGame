//
//  BattleController.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

enum messageForUserAction: String {
    case chooseAttacker = "choose your attacker."
    case chooseTarget = "choose the target."
    case chooseAction = "choose your action."
}

enum actionPossible {
    case attack, heal
}

final class BattleController: UIViewController {

    @IBOutlet private var namesOfPlayer: [UILabel]!
    @IBOutlet private var charactersImageView: [UIImageView]!
    @IBOutlet private var charactersNamesLabel: [UILabel]!
    @IBOutlet private var charactersLifePointsLabel: [UILabel]!
    
    @IBOutlet private weak var chestView: UIView!
    @IBOutlet private weak var chestLabel: UILabel!
    @IBOutlet private weak var gunImageView: UIImageView!
    
    @IBOutlet private weak var playerTurnLabel: UILabel!
    @IBOutlet private weak var attackButton: UIButton!
    @IBOutlet private weak var healButton: UIButton!
    @IBOutlet private var charactersButton: [UIButton]!
    @IBOutlet private weak var charactersButtonStackView: UIStackView!
    @IBOutlet private weak var attackOrHealButtonsStackView: UIStackView!
    
    private var turn: Int!
    private var attacker: Character!
    private var actionInterruptor = false
    private var choosenAction: actionPossible!
    private var characterCanHeal = false
    private var nameOfVictoryPlayer: String!
    
    @IBAction func tapCharacterOneButton() {
        if actionInterruptor {
            switch choosenAction {
            case .attack:
                fight(with: attacker, andTarget: 0)
            case .heal:
                heal(with: attacker, andTarget: 0)
            default:
                return
            }
        } else {
            attacker = Player.list[turn % 2].characters[0]
            if attacker.heal { characterCanHeal = true } else { characterCanHeal = false }
            updatePlayerTurnLabel(withAction: .chooseAction)
            hideActionStackView(false)
        }
    }
    
    @IBAction func tapCharacterTwoButton() {
        if actionInterruptor {
            switch choosenAction {
            case .attack:
                fight(with: attacker, andTarget: 1)
            case .heal:
                heal(with: attacker, andTarget: 1)
            default:
                return
            }
        } else {
            attacker = Player.list[turn % 2].characters[1]
            if attacker.heal { characterCanHeal = true } else { characterCanHeal = false }
            updatePlayerTurnLabel(withAction: .chooseAction)
            hideActionStackView(false)
        }
    }
    
    @IBAction func tapCharacterThreeButton() {
        if actionInterruptor {
            switch choosenAction {
            case .attack:
                fight(with: attacker, andTarget: 2)
            case .heal:
                heal(with: attacker, andTarget: 2)
            default:
                return
            }
        } else {
            attacker = Player.list[turn % 2].characters[2]
            if attacker.heal { characterCanHeal = true } else { characterCanHeal = false }
            updatePlayerTurnLabel(withAction: .chooseAction)
            hideActionStackView(false)
        }
    }
    
    @IBAction func tapAttackButton() {
        actionInterruptor = true
        choosenAction = .attack
        updatePlayerTurnLabel(withAction: .chooseTarget)
        hideActionStackView(true)
    }
    
    @IBAction func tapHealButton() {
        actionInterruptor = true
        choosenAction = .heal
        updatePlayerTurnLabel(withAction: .chooseTarget)
        hideActionStackView(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "endOfBattle" {
            let controller = segue.destination as! EndOfBattleController
            controller.nameOfWinner = nameOfVictoryPlayer
        }
    }
    
    private func fight(with attacker: Character, andTarget number: Int) {
        let indexPlayer = (turn + 1) % 2
        Player.list[indexPlayer].characters[number].lifePoint -= attacker.weapon.damagePoint
        if endOfBattleVerification() {
            performSegue(withIdentifier: "endOfBattle", sender: nil)
            return
        }
        if Player.list[indexPlayer].characters[number].lifePoint <= 0 {
            if indexPlayer == 0 {
                charactersImageView[number].image = UIImage(named: "dead")
            } else {
                charactersImageView[number + 3].image = UIImage(named: "dead")
            }
        }
        refreshCharactersLifePointsLabel()
        actionInterruptor = false
        turn += 1
        updatePlayerTurnLabel(withAction: .chooseAttacker)
        hideActionStackView(true)
    }
    
    private func heal(with healer: Character, andTarget number: Int) {
        Player.list[turn % 2].characters[number].lifePoint += healer.weapon.healPoint
        refreshCharactersLifePointsLabel()
        actionInterruptor = false
        turn += 1
        updatePlayerTurnLabel(withAction: .chooseAttacker)
        hideActionStackView(true)
    }
    
    private func endOfBattleVerification() -> Bool {
        var index = 0
        var numberOfDeadCharacter = 0
        for character in Player.list[(turn + 1) % 2].characters {
            if character.lifePoint <= 0 { numberOfDeadCharacter += 1 }
            index += 1
        }
        if numberOfDeadCharacter == 3 {
            nameOfVictoryPlayer = Player.list[turn % 2].name
            return true
        } else {
            return false
        }
    }
    
    private func hideActionStackView(_ bool: Bool) {
        var index = 0
        if characterCanHeal { healButton.isHidden = false } else { healButton.isHidden = true }
        if attacker.weapon.damagePoint <= 0 { attackButton.isHidden = true } else { attackButton.isHidden = false }
        if (actionInterruptor == true) && (choosenAction == .attack) {
            for character in Player.list[(turn + 1) % 2].characters {
                if character.lifePoint <= 0 { charactersButton[index].isHidden = true } else { charactersButton[index].isHidden = false }
                index += 1
            }
        } else {
            for character in Player.list[turn % 2].characters {
                if character.lifePoint <= 0 { charactersButton[index].isHidden = true } else { charactersButton[index].isHidden = false }
                index += 1
            }
        }
        attackOrHealButtonsStackView.isHidden = bool
        charactersButtonStackView.isHidden = !bool
    }
    
    private func initNamesOfPlayer() {
        var index = 0
        for label in namesOfPlayer {
            label.text = Player.list[index].name
            index += 1
        }
    }
    
    private func initCharactersImageView() {
        var index = 0
        for imageView in charactersImageView {
            if index <= 2 {
                imageView.image = UIImage(named: Player.list[0].characters[index].image)
                index += 1
            } else {
                imageView.image = UIImage(named: Player.list[1].characters[index - 3].image)
                index += 1
            }
        }
    }
    
    private func initCharactersNamesLabel() {
        var index = 0
        for label in charactersNamesLabel {
            if index <= 2 {
                label.text = Player.list[0].characters[index].name
                index += 1
            } else {
                label.text = Player.list[1].characters[index - 3].name
                index += 1
            }
        }
    }
    
    private func refreshCharactersLifePointsLabel() {
        var index = 0
        for label in charactersLifePointsLabel {
            if index <= 2 {
                label.text = String(Player.list[0].characters[index].lifePoint)
                index += 1
            } else {
                label.text = String(Player.list[1].characters[index - 3].lifePoint)
                index += 1
            }
        }
    }
    
    private func updatePlayerTurnLabel(withAction action: messageForUserAction) {
        playerTurnLabel.text = "\(Player.list[turn % 2].name) it's your turn, \(action.rawValue)"
    }
    
    private func initializer() {
        turn = Int.random(in: 0...1)
        
        initNamesOfPlayer()
        initCharactersImageView()
        initCharactersNamesLabel()
        refreshCharactersLifePointsLabel()
        
        attackOrHealButtonsStackView.isHidden = true
        updatePlayerTurnLabel(withAction: .chooseAttacker)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializer()
    }
}
