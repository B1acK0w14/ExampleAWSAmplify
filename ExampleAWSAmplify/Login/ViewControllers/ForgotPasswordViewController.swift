//
//  ForgotPasswordViewController.swift
//  ExampleAWSAmplify
//
//  Created by David Andres Penagos Sanchez on 14/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import UIKit
import AWSMobileClient

class ForgotPasswordViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var forgotPasswordView: ForgotPasswordView = {
        let view = ForgotPasswordView(delegate: self)
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
        self.view = forgotPasswordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.forgotPasswordView.userTextField.delegate = self
        self.forgotPasswordView.newPasswordTextField.delegate = self
        self.forgotPasswordView.confimationCodeTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.topItem?.title = "Forgot Password"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //MARK: - Functions
    func sendConfirmationCodeForgotPassword(username: String) {
        AWSMobileClient.default().forgotPassword(username: username) { (forgotPasswordResult, error) in
            if let forgotPasswordResult = forgotPasswordResult {
                switch(forgotPasswordResult.forgotPasswordState) {
                case .confirmationCodeSent:
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Hey!!!",
                                                      message: "Confirmation code sent via \(forgotPasswordResult.codeDeliveryDetails!.deliveryMedium) to: \(forgotPasswordResult.codeDeliveryDetails!.destination!)",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        self.forgotPasswordView.newPasswordTextField.isHidden = false
                        self.forgotPasswordView.confimationCodeTextField.isHidden = false
                        self.forgotPasswordView.changePasswordButton.isHidden = false
                    }
                default:
                    print("Error: Invalid case.")
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
    
    func confirmForgotPassword(username: String, newPassword: String, confirmationCode: String) {
        AWSMobileClient.default().confirmForgotPassword(username: username, newPassword: newPassword, confirmationCode: confirmationCode) { (forgotPasswordResult, error) in
            if let forgotPasswordResult = forgotPasswordResult {
                switch(forgotPasswordResult.forgotPasswordState) {
                case .done:
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Yeaaaaahhh!!",
                                                      message: "Password successfully changed",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                            self.navigationController?.popToRootViewController(animated: true)
                        }))
                        self.present(alert, animated: true)
                    }
                default:
                    print("Error: Could not change password.")
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
}

//MARK: - Extensions
extension ForgotPasswordViewController: UITextFieldDelegate {
    
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

extension ForgotPasswordViewController: ForgotPasswordDelegate {
    
    func resendConfirmationCode() {
        guard let user = self.forgotPasswordView.userTextField.text else {return}
        sendConfirmationCodeForgotPassword(username: user)
    }
    
    func changePassword() {
        guard let user = self.forgotPasswordView.userTextField.text else {return}
        guard let newPassword = self.forgotPasswordView.newPasswordTextField.text else {return}
        guard let confirmationCode = self.forgotPasswordView.confimationCodeTextField.text else {return}
        confirmForgotPassword(username: user, newPassword: newPassword, confirmationCode: confirmationCode)
    }
}
