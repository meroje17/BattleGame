//
//  EndOfBattleController.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 09/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class EndOfBattleController: UIViewController {

    @IBOutlet private weak var homeButton: UIButton!
    @IBOutlet private weak var playerWinnerLabel: UILabel!
    
    var nameOfWinner: String!
    
    @IBAction func tapHomeButton() {
        performSegue(withIdentifier: "unwinToHomeController", sender: nil)
    }
    
    private func initializer() {
        homeButton.layer.cornerRadius = homeButton.bounds.height / 2
        
        guard let name = nameOfWinner else { return }
        playerWinnerLabel.text = "\(name), you are the winner ! Congratulations !"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializer()
    }
}
