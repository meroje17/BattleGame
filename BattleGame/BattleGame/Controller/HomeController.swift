//
//  HomeController.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class HomeController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var nameFirstPlayerTextField: UITextField!
    @IBOutlet private weak var nameSecondPlayerTextField: UITextField!
    @IBOutlet private weak var goButton: UIButton!
    
    // MARK: - Type alias
    
    typealias completion = () -> ()
    
    // MARK: - User actions
    
    @IBAction private func tapGoButton() {
        emptyTextVerification {
            performSegue(withIdentifier: "tapGoButton", sender: nil)
        }
    }
    
    @objc private func textFielReturning() {
        nameFirstPlayerTextField.resignFirstResponder()
        nameSecondPlayerTextField.resignFirstResponder()
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        nameFirstPlayerTextField.text = nil
        nameSecondPlayerTextField.text = nil
    }
    
    // MARK: - Private methods
    
    private func initializer() {
        goButton.layer.cornerRadius = goButton.bounds.height / 2
        
        nameFirstPlayerTextField.delegate = self
        nameSecondPlayerTextField.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFielReturning)))
    }
    
    private func emptyTextVerification(_ completion: completion) {
        if nameFirstPlayerTextField.text == "" { error(with: .textEmpty, shake: goButton); return }
        if nameSecondPlayerTextField.text == "" { error(with: .textEmpty, shake: goButton); return }
        guard let playerOne = nameFirstPlayerTextField.text else { error(with: .textEmpty, shake: goButton); return }
        guard let playerTwo = nameSecondPlayerTextField.text else { error(with: .textEmpty, shake: goButton); return }
        let players = [Player(name: playerOne), Player(name: playerTwo)]
        Player.list = players
        completion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializer()
    }
}

// MARK: - Extension for react with user action

extension HomeController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFielReturning()
        return true
    }
}
