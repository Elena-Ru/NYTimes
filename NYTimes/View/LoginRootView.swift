//
//  LoginRootView.swift
//  NYTimes
//
//  Created by Елена Русских on 24.02.2023.
//

import UIKit

class LoginRootView: UIView {
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "NYTLogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let textDescribingView: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Dive into the hottest news in the world!"
        text.font = UIFont.boldSystemFont(ofSize: 16)
        text.textAlignment = .center
        return text
    }()
    let loginTextFieldView: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Login"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.autocapitalizationType = .none
        textField.setLeftPaddingPoints(20)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
        let image = UIImage(systemName: "person")
        imageView.image = image
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = view
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let passwordTextFieldView: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.setLeftPaddingPoints(20)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
        let image = UIImage(systemName: "lock")
        imageView.image = image
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = view
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("LOGIN", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.titleLabel?.tintColor = .darkGray
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false
        button.clipsToBounds = true
        button.layer.shadowPath = UIBezierPath(rect: button.bounds).cgPath
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Still have no account?"
        label.textAlignment = .center
        return label
    }()
    
    let singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: CGRect())
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let scrollView = UIScrollView()
        
        scrollView.contentSize = CGSize(width: self.frame.width, height: 2000)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        let topImageContainerView = UIStackView(arrangedSubviews: [logoImageView, textDescribingView])
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.distribution = .fillEqually
        topImageContainerView.setCustomSpacing(20, after: logoImageView)
        topImageContainerView.axis = .vertical
        topImageContainerView.addSubview(logoImageView)
        topImageContainerView.addSubview(textDescribingView)
        scrollView.addSubview(topImageContainerView)
        
        let textFieldStack = UIStackView(arrangedSubviews: [loginTextFieldView, passwordTextFieldView])
        textFieldStack.translatesAutoresizingMaskIntoConstraints = false
        textFieldStack.distribution = .fillEqually
        textFieldStack.setCustomSpacing(20, after: loginTextFieldView)
        textFieldStack.axis = .vertical
        textFieldStack.addSubview(passwordTextFieldView)
        textFieldStack.addSubview(loginTextFieldView)
        scrollView.addSubview(textFieldStack)
        scrollView.addSubview(loginButton)

        let signUpStack = UIStackView(arrangedSubviews: [signUpLabel, singUpButton])
        signUpStack.translatesAutoresizingMaskIntoConstraints = false
        signUpStack.distribution = .fillEqually
        signUpStack.axis = .vertical
        signUpStack.addSubview(signUpLabel)
        signUpStack.addSubview(singUpButton)
        scrollView.addSubview(signUpStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            topImageContainerView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
            topImageContainerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            topImageContainerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            topImageContainerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: topImageContainerView.topAnchor, constant: 20),
            logoImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5),
            
            textDescribingView.bottomAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: -30),
            textDescribingView.leadingAnchor.constraint(equalTo: topImageContainerView.leadingAnchor, constant: 20),
            textDescribingView.widthAnchor.constraint(equalToConstant: topImageContainerView.frame.size.width * 0.8),
            textDescribingView.heightAnchor.constraint(equalToConstant: 30),

            textFieldStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            textFieldStack.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: scrollView.frame.size.height * 0.05),
            textFieldStack.widthAnchor.constraint(equalToConstant: 200),
            textFieldStack.heightAnchor.constraint(equalToConstant: 100),

            loginTextFieldView.topAnchor.constraint(equalTo: textFieldStack.topAnchor),
            loginTextFieldView.heightAnchor.constraint(equalToConstant: 38),
            loginTextFieldView.leadingAnchor.constraint(equalTo: textFieldStack.leadingAnchor),
            loginTextFieldView.trailingAnchor.constraint(equalTo: textFieldStack.trailingAnchor),

            passwordTextFieldView.bottomAnchor.constraint(equalTo: textFieldStack.bottomAnchor),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 38),
            passwordTextFieldView.leadingAnchor.constraint(equalTo: textFieldStack.leadingAnchor),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: textFieldStack.trailingAnchor),

            loginButton.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 100),

            signUpStack.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signUpStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            signUpStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7),
            signUpStack.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func animateLogoAppearing() {
        logoImageView.transform = CGAffineTransform(rotationAngle: .pi)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut , animations: {
            self.logoImageView.transform = CGAffineTransform(rotationAngle: 2 * .pi)
        })
    }
    
    func animateTextFieldAppearing() {
        loginTextFieldView.transform = CGAffineTransform(translationX: -300, y: -30)
        self.layoutIfNeeded()
        let originalCenter = loginTextFieldView.center
        UIView.animateKeyframes(withDuration: 1, delay: 0,options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.loginTextFieldView.transform = CGAffineTransform(translationX: 0, y: -60)
                self.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.loginTextFieldView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.layoutIfNeeded()

            }
        }
    }
    
    func animatePasswordTextFieldAppearing() {
        passwordTextFieldView.transform = CGAffineTransform(translationX: -300, y: -30)
        self.layoutIfNeeded()
        let originalCenter = passwordTextFieldView.center
        UIView.animateKeyframes(withDuration: 1, delay: 0,options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.passwordTextFieldView.transform = CGAffineTransform(translationX: 0, y: -60)
                self.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.passwordTextFieldView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.layoutIfNeeded()

            }
        }
    }
}
