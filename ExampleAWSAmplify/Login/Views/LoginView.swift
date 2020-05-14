//
//  LoginView.swift
//  ExampleAWSAmplify
//
//  Created by David Andres Penagos Sanchez on 12/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    //MARK: - Properties
    private lazy var imageLogin: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 4
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
//        image.image = UIImage(named: "ExampleImage")
        image.contentMode = .scaleToFill
        return image
    }()
    
    public lazy var userTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textAlignment = NSTextAlignment.center
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.returnKeyType = .next
        textField.placeholder = "User"
        textField.tag = 0
        return textField
    }()
    
    public lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textAlignment = NSTextAlignment.center
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.tag = 1
        return textField
    }()
    
    private lazy var registerUserLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = NSTextAlignment.center
        label.isUserInteractionEnabled = true
        let attributedString = NSMutableAttributedString.init(string: "Register User")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
            NSRange.init(location: 0, length: attributedString.length));
        label.attributedText = attributedString
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(registerUser)))
        return label
    }()
    
    private lazy var forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = NSTextAlignment.center
        label.isUserInteractionEnabled = true
        let attributedString = NSMutableAttributedString.init(string: "Forgot Password?")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
            NSRange.init(location: 0, length: attributedString.length));
        label.attributedText = attributedString
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forgotPassword)))
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.init(rgb: 0xc3e5f7)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 0.4, bottom: 0, right: 0.4)
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: LoginDelegate?
    
    //MARK: - Init
    init(delegate: LoginDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func loginAction() {
        self.delegate?.loginAction()
    }
    
    @objc func registerUser() {
        self.delegate?.registerUser()
    }
    
    @objc func forgotPassword() {
        self.delegate?.forgotPassword()
    }
}

extension LoginView: ViewConfiguration {
    
    func configureViews() {
        backgroundColor = .white
    }
    
    func buildViewHierarchy() {
        self.addSubview(imageLogin)
        self.addSubview(userTextField)
        self.addSubview(passwordTextField)
        self.addSubview(registerUserLabel)
        self.addSubview(forgotPasswordLabel)
        self.addSubview(loginButton)
    }
    
    func setupConstraints() {
        imageLogin.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-150)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }
        
        userTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(imageLogin.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(userTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }
        
        registerUserLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(64)
        }
        
        forgotPasswordLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-64)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(passwordTextField.snp.bottom).offset(100)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }
    }
}
