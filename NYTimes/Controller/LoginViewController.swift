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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
