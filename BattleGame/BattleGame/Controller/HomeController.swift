//
//  HomeController.swift
//  BattleGame
//
//  Created by Jérôme Guèrin on 07/07/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class HomeController: UIViewController {

    @IBOutlet private weak var nameFirstPlayerTextField: UITextField!
    @IBOutlet private weak var nameSecondPlayerTextField: UITextField!
    @IBOutlet private weak var goButton: UIButton!
    
    typealias completion = () -> ()
    
    @IBAction private func tapGoButton() {
        emptyTextVerification {
            performSegue(withIdentifier: "tapGoButton", sender: nil)
        }
    }
    
    @objc func textFielReturning() {
        nameFirstPlayerTextField.resignFirstResponder()
        nameSecondPlayerTextField.resignFirstResponder()
    }
    
    private func initializer() {
        goButton.layer.cornerRadius = goButton.bounds.height / 2
        
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

extension HomeController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFielReturning()
        return true
    }
}
