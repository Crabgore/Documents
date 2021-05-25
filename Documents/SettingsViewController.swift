//
//  SettingsViewController.swift
//  Documents
//
//  Created by Mihail on 19.05.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    private lazy var changePassButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.setTitle("Сменить пароль", for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changePassButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var abcLabel: UILabel = {
        let label = UILabel()
        label.text = "Сортировать в обратном порядке"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var checkBox: UISwitch = {
        let checkBox = UISwitch()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        return checkBox
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(checkBox)
        view.addSubview(abcLabel)
        view.addSubview(changePassButton)
        
        if userDefaults.bool(forKey: "abc") {
            checkBox.setOn(true, animated: false)
        }
        
        let constraints = [
            checkBox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            checkBox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            abcLabel.topAnchor.constraint(equalTo: checkBox.topAnchor),
            abcLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 16),
            abcLabel.bottomAnchor.constraint(equalTo: checkBox.bottomAnchor),
            
            changePassButton.topAnchor.constraint(equalTo: checkBox.bottomAnchor, constant: 16),
            changePassButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            changePassButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            changePassButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    

    @objc private func changePassButtonPressed() {
        let vc = LoginViewController()
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @objc private func switchChanged() {
        if checkBox.isOn {
            userDefaults.setValue(true, forKey: "abc")
        } else {
            userDefaults.setValue(false, forKey: "abc")
        }
    }
}
