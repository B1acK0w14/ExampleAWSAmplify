//
//  ForgotPasswordView.swift
//  ExampleAWSAmplify
//
//  Created by David Andres Penagos Sanchez on 14/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import UIKit

class ForgotPasswordView: UIView {
    
    //MARK: - Properties
    private lazy var labelInfoForgotPassword: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = NSTextAlignment.justified
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Well! In here you can change your password, but please, don't forget again!!"
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

    public lazy var resendConfirmationCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = NSTextAlignment.center
        label.isUserInteractionEnabled = true
        let attributedString = NSMutableAttributedString.init(string: "Send Confirmation Code")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
            NSRange.init(location: 0, length: attributedString.length));
        label.attributedText = attributedString
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resendConfirmationCode)))
        return label
    }()
    
    public lazy var newPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textAlignment = NSTextAlignment.center
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.returnKeyType = .next
        textField.isSecureTextEntry = true
        textField.placeholder = "New Password"
        textField.isHidden = true
        textField.tag = 1
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
    
    public lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Password", for: .normal)
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
        button.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: ForgotPasswordDelegate?
    
    //MARK: - Init
    init(delegate: ForgotPasswordDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func resendConfirmationCode() {
        self.delegate?.resendConfirmationCode()
    }
    
    @objc func changePassword() {
        self.delegate?.changePassword()
    }
}

extension ForgotPasswordView: ViewConfiguration {
    func configureViews() {
        backgroundColor = .white
    }
    
    func buildViewHierarchy() {
        self.addSubview(labelInfoForgotPassword)
        self.addSubview(userTextField)
        self.addSubview(resendConfirmationCodeLabel)
        self.addSubview(newPasswordTextField)
        self.addSubview(confimationCodeTextField)
        self.addSubview(changePasswordButton)
    }
    
    func setupConstraints() {
        labelInfoForgotPassword.snp.makeConstraints { (make) in
            make.height.equalTo(80)
            make.topMargin.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(67)
            make.trailing.equalToSuperview().offset(-67)
        }
        
        userTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(labelInfoForgotPassword.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }
        
        resendConfirmationCodeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(userTextField.snp.bottom).offset(10)
            make.centerX.equalTo(userTextField.snp.centerX)
        }
        
        newPasswordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(userTextField.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }
        
        confimationCodeTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }
        
        changePasswordButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(confimationCodeTextField.snp.bottom).offset(140)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }
    }
}
