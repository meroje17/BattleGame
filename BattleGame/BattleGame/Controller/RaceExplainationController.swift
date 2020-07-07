//
//  RaceExplainationController.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class RaceExplainationController: UIViewController {

    @IBOutlet private weak var createTeamButton: UIButton!
    
    private func initUI() {
        createTeamButton.layer.cornerRadius = createTeamButton.bounds.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
}
