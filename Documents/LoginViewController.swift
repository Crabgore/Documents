//
//  LoginViewController.swift
//  Documents
//
//  Created by Mihail on 19.05.2021.
//

import UIKit
import KeychainAccess

class LoginViewController: UIViewController {
    
    private let keychain = Keychain(service: "documents")
    private var firstPass = ""
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.placeholder = "пароль"
        textField.isUserInteractionEnabled = true
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    

    private func isPassExists() -> Bool {
        let pass = keychain["password"]
        return pass != nil
    }
    
    private func savePass(pass: String) {
        if pass.count >= 4 {
            keychain["password"] = pass
        } else {
            showAlert(error: "Пароль должен содержать минимум 4 символа")
        }
    }
    
    private func getPass() -> String {
        return keychain["password"]!
    }
    
    func showAlert(error: String) {
        let alertController = UIAlertController(title: "Ошибка!", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK")
        }
        alertController.addAction(okAction)
        navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    @objc private func loginButtonPressed() {
        if emailTextField.text != nil && emailTextField.text != "" {
            if !isPassExists() && firstPass == "" {
                firstPass = emailTextField.text!
                emailTextField.text = ""
                loginButton.setTitle("Повторите пароль", for: .normal)
            } else if !isPassExists() && firstPass != "" {
                if emailTextField.text! == firstPass {
                    savePass(pass: emailTextField.text!)
                    let vc = ViewController()
                    navigationController?.pushViewController(vc, animated: true)
                } else {
                    showAlert(error: "Пароли не совпадают")
                }
            } else if isPassExists() && emailTextField.text! == getPass() {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            }
        } else {
            showAlert(error: "Введите пароль!")
        }
    }
    
    private func setupViews() {
        if isPassExists() {
            loginButton.setTitle("Введите пароль", for: .normal)
        } else {
            loginButton.setTitle("Создать пароль", for: .normal)
        }
        
        view.addSubview(emailTextField)
        view.addSubview(loginButton)
        
        let constraints = [
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            loginButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 55),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
