//
//  RegisterDelegate.swift
//  ExampleAWSAmplify
//
//  Created by David Andres Penagos Sanchez on 13/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import Foundation

protocol RegisterDelegate: class {
    func registerAction()
    func resendConfirmationCode()
    func sendConfirmationCode()
}
