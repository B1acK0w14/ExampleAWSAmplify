//
//  ExampleAWSAmplifyTests.swift
//  ExampleAWSAmplifyTests
//
//  Created by David Andres Penagos Sanchez on 12/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import XCTest
@testable import ExampleAWSAmplify

class ExampleAWSAmplifyTests: XCTestCase {
    
    var sut1: LoginViewController!
    var sut2: RegisterUserViewController!
    var sut3: ForgotPasswordViewController!

    override func setUp() {
        super.setUp()
        sut1 = LoginViewController()
        sut2 = RegisterUserViewController()
        sut3 = ForgotPasswordViewController()
    }
    
    override func tearDown() {
        sut1 = nil
        sut2 = nil
        sut3 = nil
        super.tearDown()
    }
    
    func testSucessValidationEmptyFieldsLogin() {
        //given
        let user = "123"
        let password = "123"
        
        //when
        let validation = sut1.isEmptyFields(userText: user, passwordText: password)
        
        //then
        XCTAssertEqual(validation, false)
    }
    
    func testFailureValidationEmptyFieldsLogin() {
        //given
        let user = "123"
        let password = ""
        
        //when
        let validation = sut1.isEmptyFields(userText: user, passwordText: password)
        
        //then
        XCTAssertEqual(validation, true)
    }
    
    func testSucessValidationEmptyFieldsRegister() {
        //given
        let user = "123"
        let password = "123"
        let email = "123@example.com"
        let phone = "+57123456789"
        
        //when
        let validation = sut2.isEmptyFields(userText: user, passwordText: password, emailText: email, phoneText: phone)
        
        //then
        XCTAssertEqual(validation, false)
    }
    
    func testFailureValidationEmptyFieldsRegister() {
        //given
        let user = "123"
        let password = ""
        let email = "123@example.com"
        let phone = ""
        
        //when
        let validation = sut2.isEmptyFields(userText: user, passwordText: password, emailText: email, phoneText: phone)
        
        //then
        XCTAssertEqual(validation, true)
    }
    
    func testSucessValidationEmptyFieldsForgotPassword() {
        //given
        let user = "123"
        
        //when
        let validation = sut3.isEmptyFields(userText: user)
        
        //then
        XCTAssertEqual(validation, false)
    }
    
    func testFailureValidationEmptyFieldsForgotPassword() {
        //given
        let user = ""
        
        //when
        let validation = sut3.isEmptyFields(userText: user)
        
        //then
        XCTAssertEqual(validation, true)
    }
}
