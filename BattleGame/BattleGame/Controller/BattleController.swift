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

    // MARK: - Outlets
    
    @IBOutlet private var namesOfPlayer: [UILabel]!
    @IBOutlet private var charactersImageView: [UIImageView]!
    @IBOutlet private var charactersNamesLabel: [UILabel]!
    @IBOutlet private var charactersLifePointsLabel: [UILabel]!
    
    @IBOutlet private weak var chestView: UIView!
    @IBOutlet private weak var weaponImageView: UIImageView!
    @IBOutlet private weak var chestLabel: UILabel!
    @IBOutlet private weak var chestButton: UIButton!
    
    @IBOutlet private weak var playerTurnLabel: UILabel!
    @IBOutlet private weak var attackButton: UIButton!
    @IBOutlet private weak var healButton: UIButton!
    @IBOutlet private var charactersButton: [UIButton]!
    @IBOutlet private weak var charactersButtonStackView: UIStackView!
    @IBOutlet private weak var attackOrHealButtonsStackView: UIStackView!
    
    // MARK: - Properties
    
    private var turn: Int!
    private var fighter: Character!
    private var actionInterruptor = false
    private var choosenAction: actionPossible!
    private var nameOfVictoryPlayer: String!
    private var chest: Chest = Chest()
    
    // MARK: - Actions
    
    @IBAction func tapCharacterButton(_ sender: UIButton) {
        if actionInterruptor {
            switch choosenAction {
            case .attack:
                fight(with: fighter, andTarget: sender.tag)
            case .heal:
                heal(with: fighter, andTarget: sender.tag)
            default:
                return
            }
        } else {
            fighter = Player.list[turn % 2].characters[sender.tag]
            updatePlayerTurnLabel(withAction: .chooseAction)
            presentAction(true)
        }
    }
    
    @IBAction func tapActionButton(_ sender: UIButton) {
        actionInterruptor = true
        if sender.tag == 0 { choosenAction = .attack } else { choosenAction = .heal }
        updatePlayerTurnLabel(withAction: .chooseTarget)
        presentAction(false)
    }
    
    @IBAction func tapChestButton() {
        chestView.isHidden = true
        charactersButtonStackView.isUserInteractionEnabled = true
        attackOrHealButtonsStackView.isUserInteractionEnabled = true
    }
    
    // MARK: - Private methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "endOfBattle" {
            let controller = segue.destination as! EndOfBattleController
            controller.nameOfWinner = nameOfVictoryPlayer
        }
    }
    
    private func fight(with attacker: Character, andTarget number: Int) {
        let indexOpponentPlayer = (turn + 1) % 2
        var character = Player.list[indexOpponentPlayer].characters[number]
        character.lifePoint = attacker.attack(target: character)
        if endOfBattleVerification() {
            performSegue(withIdentifier: "endOfBattle", sender: nil)
            return
        }
        if character.lifePoint <= 0 {
            if indexOpponentPlayer == 0 {
                charactersImageView[number].image = UIImage(named: "dead")
            } else {
                charactersImageView[number + 3].image = UIImage(named: "dead")
            }
        }
        nextTurn()
    }
    
    private func heal(with healer: Character, andTarget number: Int) {
        var character = Player.list[turn % 2].characters[number]
        character.lifePoint = healer.heal(target: character)
        nextTurn()
    }
    
    private func nextTurn() {
        updateLifePoints()
        actionInterruptor = false
        turn += 1
        isTheChestOpen()
        updatePlayerTurnLabel(withAction: .chooseAttacker)
        presentAction(false)
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
    
    private func presentAction(_ bool: Bool) {
        if bool == true {
            hideActionStackView(!bool)
            if fighter.canHeal { healButton.isHidden = false } else { healButton.isHidden = true }
            if fighter.canAttack { attackButton.isHidden = false } else { attackButton.isHidden = true }
        } else {
            var index = 0
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
            hideActionStackView(!bool)
        }
    }
    
    private func hideActionStackView(_ bool: Bool) {
        attackOrHealButtonsStackView.isHidden = bool
        charactersButtonStackView.isHidden = !bool
    }
    
    private func isTheChestOpen() {
        chest.randomTurn = chest.haveRandomTurn()
        guard let weapon = chest.isTheChestOpen() else { return }
        chest.assignate(weapon)
        presentChestView()
    }
    
    private func presentChestView() {
        chestView.isHidden = false
        weaponImageView.image = UIImage(named: Player.list[chest.randomPlayer].characters[chest.randomCharacter].weapon.name)
        let player = Player.list[chest.randomPlayer]
        let character = player.characters[chest.randomCharacter]
        let weapon = character.weapon
        chestLabel.text = "\(character.name) of \(player.name) find a \(weapon.name) (\(weapon.damagePoint) damage, \(weapon.healPoint) heal)."
        charactersButtonStackView.isUserInteractionEnabled = false
        attackOrHealButtonsStackView.isUserInteractionEnabled = false
    }
    
    private func initUI() {
        for index in 0...5 {
            if index <= 2 {
                if index < 2 {
                    namesOfPlayer[index].text = Player.list[index].name
                }
                charactersNamesLabel[index].text = Player.list[0].characters[index].name
                charactersImageView[index].image = UIImage(named: Player.list[0].characters[index].image)
            } else {
                charactersNamesLabel[index].text = Player.list[1].characters[index - 3].name
                charactersImageView[index].image = UIImage(named: Player.list[1].characters[index - 3].image)
            }
        }
    }
    
    private func updateLifePoints() {
        for index in 0...5 {
            if index <= 2 {
                charactersLifePointsLabel[index].text = String(Player.list[0].characters[index].lifePoint)
            } else {
                charactersLifePointsLabel[index].text = String(Player.list[1].characters[index - 3].lifePoint)
            }
        }
    }
    
    private func updatePlayerTurnLabel(withAction action: messageForUserAction) {
        playerTurnLabel.text = "\(Player.list[turn % 2].name) it's your turn, \(action.rawValue)"
    }
    
    private func roundedViewAndButton() {
        chestButton.layer.cornerRadius = chestButton.bounds.height / 2
        chestView.layer.cornerRadius = 10
        for button in charactersButton {
            button.layer.cornerRadius = 10
        }
        attackButton.layer.cornerRadius = 10
        healButton.layer.cornerRadius = 10
    }
    
    private func initializer() {
        turn = Int.random(in: 0...1)
        initUI()
        updateLifePoints()
        roundedViewAndButton()
        attackOrHealButtonsStackView.isHidden = true
        updatePlayerTurnLabel(withAction: .chooseAttacker)
    }
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializer()
    }
}
