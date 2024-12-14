//
//  LoginViewController.swift
//  FirebaseLogin
//
//  Created by Sezgin on 24.04.2022.
//

import UIKit

protocol SignInViewControllerProtocol: AnyObject {
    func updateWithSuccess()
    func updateWithNotSuccess(error: LocalError)
}

class SignInViewController: DefaultViewController, SignInViewControllerProtocol {
    
    override var navigationBarBackgroundColor: UIColor {
        return .white
    }
    
    override var navigationBarHidden: Bool {
        return false
    }
    
    var presenter: SignInPresenterProtocol?
    
    private var userNameTextField: UITextField = {
        let textField = MakeProperty.makeTextField("username")
        textField.autocapitalizationType = .none
        textField.becomeFirstResponder()
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = MakeProperty.makeTextField("password")
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        return textField
    }()
    
    private var goToAppButton: UIButton = {
        let button = MakeProperty.makeLoginButton("Go to the App")
        button.addTarget(self, action: #selector(handleGoAppButton), for: .touchUpInside)
        return button
    }()
    
    private var facebookLoginButton: UIButton = {
        let button = MakeProperty.makeIconButton()
        button.addTarget(self, action: #selector(handleGoAppByGoogleLoginButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        userNameTextField.text = ""
        passwordTextField.text = ""
    }
    
    @objc private func handleGoAppByGoogleLoginButton() {
 
        presenter?.notifyOauth2LoginUserButtonTapped()
    }
    
    @objc private func handleGoAppButton() {
        if (userNameTextField.text != "") && (passwordTextField.text != "") {
            guard let username = userNameTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            presenter?.notifyDidButtonTapped(username: username, password: password)
        } else {
            self.showCommonAlert(title: "Error!", message: "You should fill username and password!")
        }
     }
    
    func updateWithSuccess() {
        showSuccessHud(labelText: "登陆成功~~~", delay: 2.0)
    }
    
    func updateWithNotSuccess(error: LocalError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
                guard let self = self else { return }
                self.userNameTextField.text = nil
                self.passwordTextField.text = nil
                self.userNameTextField.becomeFirstResponder()
            }
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - UI Configurations
    private func configureUI() {
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 1, alpha: 1)
        view.addSubview(userNameTextField)
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),
            userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            userNameTextField.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(goToAppButton)
        NSLayoutConstraint.activate([
            goToAppButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 60),
            goToAppButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToAppButton.heightAnchor.constraint(equalToConstant: 50),
            goToAppButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(facebookLoginButton)
        NSLayoutConstraint.activate([
            facebookLoginButton.topAnchor.constraint(equalTo: goToAppButton.bottomAnchor, constant: 60),
            facebookLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            facebookLoginButton.heightAnchor.constraint(equalToConstant: 50),
            facebookLoginButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        facebookLoginButton.layer.cornerRadius = 25
        facebookLoginButton.layer.borderWidth = 1.0
        facebookLoginButton.layer.borderColor = UIColor(red: 248/255, green: 248/255, blue: 0.7, alpha: 1).cgColor
    }
}
