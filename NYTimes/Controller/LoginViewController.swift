//
//  LoginViewController.swift
//  NYTimes
//
//  Created by Елена Русских on 24.02.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    var rootView = LoginRootView()
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    @objc func signUp() {
        let alert  = UIAlertController(title: "Register",
                                       message: "Register",
                                       preferredStyle: .alert)
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
            textEmail.borderStyle = .roundedRect
        }
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
            textPassword.borderStyle = .roundedRect
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let emailField = alert.textFields?[0],
                  let passwordField = alert.textFields?[1],
                  let email = emailField.text,
                  let password = passwordField.text else {return}
            let userDefaults = UserDefaults.standard
            userDefaults.set(email, forKey: "email")
            userDefaults.set(password, forKey: "password")
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        rootView.singUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        rootView.animateLogoAppearing()
        rootView.animateTextFieldAppearing()
        rootView.animatePasswordTextFieldAppearing()
    }
}
