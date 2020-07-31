//
//  RaceExplainationController.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class RaceExplainationController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var createTeamButton: UIButton!
    
    // MARK: - Private method
    
    private func initUI() {
        createTeamButton.layer.cornerRadius = createTeamButton.bounds.height / 2
    }
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
}
