//
//  EndOfBattleController.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 09/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class EndOfBattleController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var homeButton: UIButton!
    @IBOutlet private weak var playerWinnerLabel: UILabel!
    
    // MARK: - Property
    
    var nameOfWinner: String!
    
    // MARK: - Action
    
    @IBAction func tapHomeButton() {
        performSegue(withIdentifier: "unwinToHomeController", sender: nil)
    }
    
    // MARK: - Private method
    
    private func initializer() {
        homeButton.layer.cornerRadius = homeButton.bounds.height / 2
        homeButton.layer.borderWidth = 2
        homeButton.layer.borderColor = UIColor.yellow.cgColor
        
        guard let name = nameOfWinner else { return }
        playerWinnerLabel.text = "\(name), you are the winner ! Congratulations !"
    }
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializer()
    }
}
