//
//  TeamCreaterController.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class TeamCreaterController: UIViewController {

    @IBOutlet private weak var chooseYourTeamLabel: UILabel!
    @IBOutlet private var namesTextField: [UITextField]!
    @IBOutlet private var racesSegmentedControl: [UISegmentedControl]!
    @IBOutlet private weak var launchBattleButton: UIButton!
    
    typealias completion = () -> ()
    private var playerIndex = 0
    
    @IBAction func tapLaunchBattleButton() {
        if emptyTextVerification() {
            createTeam {
                if playerIndex == 0 {
                    chooseYourTeamLabel.text = "\(Player.list[1].name) choose your team !"
                    resetUI()
                    playerIndex += 1
                } else {
                    performSegue(withIdentifier: "tapLaunchBattleButton", sender: nil)
                }
            }
        } else { return }
    }
    
    @objc func resignTextField() {
        for name in namesTextField {
            name.resignFirstResponder()
        }
    }
    
    private func initializer() {
        launchBattleButton.layer.cornerRadius = launchBattleButton.bounds.height / 2
        
        chooseYourTeamLabel.text = "\(Player.list[0].name) choose your team !"
        
        for name in namesTextField {
            name.delegate = self
        }
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resignTextField)))
    }
    
    private func emptyTextVerification() -> Bool {
        for name in namesTextField {
            if name.text == "" || name.text == nil { error(with: .textEmpty, shake: launchBattleButton); return false }
        }
        return true
    }
    
    private func createTeam(_ completion: completion) {
        var index = 0
        for race in racesSegmentedControl {
            switch race.selectedSegmentIndex {
            case 0:
                Player.list[playerIndex].characters.append(Knight(namesTextField[index].text!))
            case 1:
                Player.list[playerIndex].characters.append(Ork(namesTextField[index].text!))
            case 2:
                Player.list[playerIndex].characters.append(Wizard(namesTextField[index].text!))
            default:
                return
            }
            index += 1
        }
        completion()
    }
    
    private func resetUI() {
        for name in namesTextField {
            name.text = nil
        }
        for race in racesSegmentedControl {
            race.selectedSegmentIndex = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializer()
    }
}

extension TeamCreaterController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignTextField()
        return true
    }
}
