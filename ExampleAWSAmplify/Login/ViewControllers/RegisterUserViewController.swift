//
//  RegisterUserViewController.swift
//  ExampleAWSAmplify
//
//  Created by David Andres Penagos Sanchez on 13/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import UIKit
import AWSMobileClient

class RegisterUserViewController: UIViewController {
    
    //MAKR: - Properties
    private lazy var registerUserView: RegisterUserView = {
        let view = RegisterUserView(delegate: self)
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
        self.view = registerUserView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerUserView.userTextField.delegate = self
        self.registerUserView.passwordTextField.delegate = self
        self.registerUserView.emailTextField.delegate = self
        self.registerUserView.phoneTextField.delegate = self
        self.registerUserView.confimationCodeTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.topItem?.title = "Register"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //MARK: - Functions
    func signUpUser(username: String, password: String, email: String, phone: String) {
        AWSMobileClient.default().signUp(username: username, password: password, userAttributes: ["email":"\(email)", "phone_number":"\(phone)"]) { (signUpResult, error) in
            if let signUpResult = signUpResult {
                switch (signUpResult.signUpConfirmationState) {
                case .confirmed:
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Yeaaaaahhh!!",
                                                      message: "User is signed up and confirmed.",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                case .unconfirmed:
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "User is not confirmed",
                                                      message: "needs verification via \(signUpResult.codeDeliveryDetails!.deliveryMedium) sent at \(signUpResult.codeDeliveryDetails!.destination!)",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        self.registerUserView.confimationCodeTextField.isHidden = false
                        self.registerUserView.sendConfirmationCodeButton.isHidden = false
                        self.registerUserView.resendConfirmationCodeLabel.isHidden = false
                    }
                case .unknown:
                    print("Unexpected case")
                }
            } else if let error = error {
                if error is AWSMobileClientError {
                    print(error)
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Ooooooopppsssss!!",
                                                      message: error.localizedDescription,
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    func confirmSignUp(username: String, confirmCode: String) {
        AWSMobileClient.default().confirmSignUp(username: username, confirmationCode: confirmCode) { (signUpResult, error) in
            if let signUpResult = signUpResult {
                switch(signUpResult.signUpConfirmationState) {
                case .confirmed:
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Yeaaaaahhh!!",
                                                      message: "User is signed up and confirmed.",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                            self.navigationController?.popToRootViewController(animated: true)
                        }))
                        self.present(alert, animated: true)
                    }
                case .unconfirmed:
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "User is not confirmed",
                                                      message: "needs verification via \(signUpResult.codeDeliveryDetails!.deliveryMedium) sent at \(signUpResult.codeDeliveryDetails!.destination!)",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                case .unknown:
                    print("Unexpected case")
                }
            } else if let error = error {
                if error is AWSMobileClientError {
                    print(error)
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Ooooooopppsssss!!",
                                                      message: error.localizedDescription,
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    func resendConfirmationCode(username: String) {
        AWSMobileClient.default().resendSignUpCode(username: username, completionHandler: { (result, error) in
            if let signUpResult = result {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Resend code!!!",
                                                  message: "A verification code has been sent via \(signUpResult.codeDeliveryDetails!.deliveryMedium) sent at \(signUpResult.codeDeliveryDetails!.destination!)",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            } else if let error = error {
                if error is AWSMobileClientError {
                    print(error)
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Ooooooopppsssss!!",
                                                      message: error.localizedDescription,
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
            }
        })
    }
}

//MARK: - Extensions
extension RegisterUserViewController: UITextFieldDelegate {
    
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

extension RegisterUserViewController: RegisterDelegate {
    
    func registerAction() {
        guard let user = self.registerUserView.userTextField.text else {return}
        guard let password = self.registerUserView.passwordTextField.text else {return}
        guard let email = self.registerUserView.emailTextField.text else {return}
        guard let phone = self.registerUserView.phoneTextField.text else {return}
        signUpUser(username: user, password: password, email: email, phone: phone)
    }
    
    func resendConfirmationCode() {
        guard let user = self.registerUserView.userTextField.text else {return}
        resendConfirmationCode(username: user)
    }
    
    func sendConfirmationCode() {
        guard let code = self.registerUserView.confimationCodeTextField.text else {return}
        guard let user = self.registerUserView.userTextField.text else {return}
        confirmSignUp(username: user, confirmCode: code)
    }
}
