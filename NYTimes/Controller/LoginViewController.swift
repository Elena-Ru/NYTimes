//
//  LoginViewController.swift
//  NYTimes
//
//  Created by Елена Русских on 24.02.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var mainTabbarController: MainTabBarController?
    
    var rootView = LoginRootView()
    
    private var handle: AuthStateDidChangeListenerHandle!
    
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
            
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                //                else {
                //                    Auth.auth().signIn(withEmail: email, password: password)
                //                }
                
            }
            //            let userDefaults = UserDefaults.standard
            //            userDefaults.set(email, forKey: "email")
            //            userDefaults.set(password, forKey: "password")
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func login(){
        guard let email = rootView.loginTextFieldView.text,
              let password = rootView.passwordTextFieldView.text,
              email.count > 0,
              password.count > 0 else {
            let alert = UIAlertController(title: "ERROR", message: "Login/password is not entered", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                alert.dismiss(animated: true, completion: nil)
                self.dismiss(animated: true)
            })
            )
            present(alert, animated: true)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
//        let mainVController = UINavigationController(rootViewController: mainTabbarController!)
//        mainVController.modalPresentationStyle = .fullScreen
//        mainTabbarController?.modalTransitionStyle = .flipHorizontal
//        present(mainVController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.handle = Auth.auth().addStateDidChangeListener({ auth, user in
            if user != nil {
                let mainVController = UINavigationController(rootViewController: self.mainTabbarController!)
                mainVController.modalPresentationStyle = .fullScreen
                self.mainTabbarController?.modalTransitionStyle = .flipHorizontal
                self.present(mainVController, animated: true)
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainTabbarController = MainTabBarController()
        rootView.singUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        rootView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        rootView.animateLogoAppearing()
        rootView.animateTextFieldAppearing()
        rootView.animatePasswordTextFieldAppearing()
    }
    override func viewDidDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle)
    }
}
