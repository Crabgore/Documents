//
//  NewPassViewController.swift
//  Documents
//
//  Created by Mihail on 19.05.2021.
//

import UIKit
import KeychainAccess

class NewPassViewController: UIViewController {
    
    private let keychain = Keychain(service: "documents")
    
    private let newPassTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.placeholder = "введите новый пароль"
        textField.isUserInteractionEnabled = true
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var changePassButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.setTitle("Сменить", for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(newPassTextField)
        view.addSubview(changePassButton)
        view.backgroundColor = .white
        
        let constraints = [
            newPassTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            newPassTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            newPassTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            changePassButton.topAnchor.constraint(equalTo: newPassTextField.bottomAnchor, constant: 16),
            changePassButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            changePassButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            changePassButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    

    @objc private func okButtonPressed() {
        if newPassTextField.text != nil && newPassTextField.text != "" {
            savePass(pass: newPassTextField.text!)
            self.dismiss(animated: true, completion: nil)
        } else {
            showAlert(error: "Введти пароль")
        }
    }
    
    private func savePass(pass: String) {
        if pass.count >= 4 {
            keychain["password"] = pass
        } else {
            showAlert(error: "Пароль должен содержать минимум 4 символа")
        }
    }
    
    func showAlert(error: String) {
        let alertController = UIAlertController(title: "Ошибка!", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK")
        }
        alertController.addAction(okAction)
        navigationController?.present(alertController, animated: true, completion: nil)
    }
}
