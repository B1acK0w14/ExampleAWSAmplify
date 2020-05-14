//
//  ForgotPasswordDelegate.swift
//  ExampleAWSAmplify
//
//  Created by David Andres Penagos Sanchez on 14/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import Foundation

protocol ForgotPasswordDelegate: class {
    func resendConfirmationCode()
    func changePassword()
}
