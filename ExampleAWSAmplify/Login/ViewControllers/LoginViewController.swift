//
//  ViewController.swift
//  ExampleAWSAmplify
//
//  Created by David Andres Penagos Sanchez on 12/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import UIKit
import AWSMobileClient

class LoginViewController: UIViewController {
    
    //MAKR: - Properties
    private lazy var loginView: LoginView = {
        let view = LoginView(delegate: self)
        return view
    }()
    
    //MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginView.userTextField.delegate = self
        self.loginView.passwordTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    
    //MARK: - Functions
    func statusUser() {
        switch (AWSMobileClient.default().currentUserState) {
        case .signedIn:
            DispatchQueue.main.async {
                print("Logged In")
            }
        case .signedOut:
            DispatchQueue.main.async {
                print("Signed Out")
            }
        default:
            AWSMobileClient.default().signOut()
        }
    }
    
    func loginUser(username: String, password: String) {
        AWSMobileClient.default().signIn(username: username, password: password) { (signInResult, error) in
            if let error = error {
                if error is AWSMobileClientError {
                    print(error)
                }
            } else if let signInResult = signInResult {
                switch (signInResult.signInState) {
                case .signedIn:
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(HomeViewController(), animated: true)
                    }
                case .smsMFA:
                    print("SMS message sent to \(signInResult.codeDetails!.destination!)")
                default:
                    print("Sign In needs info which is not et supported.")
                }
            }
        }
    }
}

//MARK: - Extensions
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            return true;
        }
        return false
    }
}

extension LoginViewController: LoginDelegate {
    
    func loginAction() {
        guard let userText = self.loginView.userTextField.text else {return}
        guard let passwordText = self.loginView.passwordTextField.text else {return}
        
        if userText.isEmpty || passwordText.isEmpty
        {
            let alert = UIAlertController(title: "User or Password incorrect.",
                                          message: " Please verify and try again.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            loginUser(username: userText, password: passwordText)
        }
    }
    
    func registerUser() {
        self.navigationController?.pushViewController(RegisterUserViewController(), animated: true)
    }
    
    func forgotPassword() {
        self.navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
}
