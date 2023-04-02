//
//  ViewController.swift
//  Firebase practice
//
//  Created by Adlet Zhantassov on 01.04.2023.
//

import UIKit
import SnapKit
import Firebase

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var appLabel: UILabel = {
       let label = UILabel()
        label.text = "ToDoFire App"
        label.font = .systemFont(ofSize: 40)
        label.textColor = .white
        return label
    }()
    
    private lazy var userDoesNotExistLabel: UILabel = {
       let label = UILabel()
        label.text = "User does not exist"
        label.font = .systemFont(ofSize: 30)
        label.textColor = .red
        label.alpha = 0
        return label
    }()
    
    private lazy var  userTF: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        return tf
    }()
    
    private lazy var  passwordTF: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                let navController = UINavigationController(rootViewController: TasksViewController())
                navController.modalPresentationStyle = .fullScreen
                self?.present(navController, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userTF.text = ""
        passwordTF.text = ""
    }
    
    private func displayWarningLabel(withText text: String) {
        userDoesNotExistLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, animations: { [weak self] in
            self?.userDoesNotExistLabel.alpha = 1
        }) { [weak self] complete in
            self?.userDoesNotExistLabel.alpha = 0
        }
        
        
    }
    
    @objc func loginButtonPressed() {
        guard let email = userTF.text,
              let password = passwordTF.text,
                  email != "",
                  password != "" else {
            displayWarningLabel(withText: "Info is incorrect")
            return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if error != nil {
                self?.displayWarningLabel(withText: "Error occured")
                return
            }
            
            if user != nil {
                let navController = UINavigationController(rootViewController: TasksViewController())
                navController.modalPresentationStyle = .fullScreen
                self?.present(navController, animated: true)
                return
            }
            self?.displayWarningLabel(withText: "No such user")
        }
    }
    
    @objc func registerButtonPressed() {
        guard let email = userTF.text,
              let password = passwordTF.text,
                  email != "",
                  password != "" else {
            displayWarningLabel(withText: "Info is incorrect")
            return }
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil {
                if user != nil {
//                    let navController = UINavigationController(rootViewController: TasksViewController())
//                    navController.modalPresentationStyle = .fullScreen
//                    self.present(navController, animated: true)
                } else {
                    print("user is not created")
                }
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}

extension ViewController {
    private func setupViews() {
        view.backgroundColor = .cyan
        let views = [appLabel,userDoesNotExistLabel,userTF,passwordTF,loginButton,registerButton]
        views.forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        
        appLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        userDoesNotExistLabel.snp.makeConstraints { make in
            make.top.equalTo(appLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        userTF.snp.makeConstraints { make in
            make.top.equalTo(userDoesNotExistLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view.snp.leading).offset(50)
            make.trailing.equalTo(view.snp.trailing).offset(-50)
        }
        
        passwordTF.snp.makeConstraints { make in
            make.top.equalTo(userTF.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view.snp.leading).offset(50)
            make.trailing.equalTo(view.snp.trailing).offset(-50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTF.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        registerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
    }
}

