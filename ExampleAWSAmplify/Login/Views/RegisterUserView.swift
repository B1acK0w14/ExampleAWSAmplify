//
//  RegisterUserView.swift
//  ExampleAWSAmplify
//
//  Created by David Andres Penagos Sanchez on 13/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import UIKit

class RegisterUserView: UIView {
    
    //MARK: - Properties
    private lazy var labelInfoRegister: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = NSTextAlignment.justified
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Add some information to continue into this fabulous app!. This will be end soon!"
        return label
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
        textField.returnKeyType = .next
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.tag = 1
        return textField
    }()
    
    public lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textAlignment = NSTextAlignment.center
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.returnKeyType = .next
        textField.placeholder = "Email"
        textField.tag = 2
        return textField
    }()
    
    public lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textAlignment = NSTextAlignment.center
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.placeholder = "Phone"
        textField.tag = 3
        return textField
    }()
    
    public lazy var confimationCodeTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textAlignment = NSTextAlignment.center
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.placeholder = "ConfirmationCode"
        textField.isHidden = true
        return textField
    }()
    
    public lazy var sendConfirmationCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.init(rgb: 0xc3e5f7)
        button.isHidden = true
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 0.4, bottom: 0, right: 0.4)
        button.addTarget(self, action: #selector(sendConfirmationCode), for: .touchUpInside)
        return button
    }()
    
    public lazy var resendConfirmationCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = NSTextAlignment.center
        label.isUserInteractionEnabled = true
        label.isHidden = true
        let attributedString = NSMutableAttributedString.init(string: "Resend Confirmation Code")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
            NSRange.init(location: 0, length: attributedString.length));
        label.attributedText = attributedString
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resendConfirmationCode)))
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.init(rgb: 0xc3e5f7)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 0.4, bottom: 0, right: 0.4)
        button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: RegisterDelegate?
    
    //MARK: - Init
    init(delegate: RegisterDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func registerAction() {
        self.delegate?.registerAction()
    }
    
    @objc func sendConfirmationCode() {
        self.delegate?.sendConfirmationCode()
    }
    
    @objc func resendConfirmationCode() {
        self.delegate?.resendConfirmationCode()
    }
}

extension RegisterUserView: ViewConfiguration {
    
    func configureViews() {
        backgroundColor = .white
    }
    
    func buildViewHierarchy() {
        self.addSubview(labelInfoRegister)
        self.addSubview(userTextField)
        self.addSubview(passwordTextField)
        self.addSubview(emailTextField)
        self.addSubview(phoneTextField)
        self.addSubview(confimationCodeTextField)
        self.addSubview(sendConfirmationCodeButton)
        self.addSubview(resendConfirmationCodeLabel)
        self.addSubview(registerButton)
    }
    
    func setupConstraints() {
        labelInfoRegister.snp.makeConstraints { (make) in
            make.height.equalTo(80)
            make.topMargin.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(67)
            make.trailing.equalToSuperview().offset(-67)
        }
        
        userTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(labelInfoRegister.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(userTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }
        
        phoneTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }
        
        confimationCodeTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(phoneTextField.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(64)
        }
        
        sendConfirmationCodeButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(phoneTextField.snp.bottom).offset(40)
            make.leading.equalTo(confimationCodeTextField.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-64)
        }
        
        resendConfirmationCodeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(confimationCodeTextField.snp.bottom).offset(10)
            make.centerX.equalTo(confimationCodeTextField.snp.centerX)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(phoneTextField.snp.bottom).offset(140)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }
    }
}
