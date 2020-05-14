//
//  LoginDelegate.swift
//  ExampleAWSAmplify
//
//  Created by David Andres Penagos Sanchez on 13/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import Foundation

protocol LoginDelegate: class {
    func loginAction()
    func registerUser()
    func forgotPassword()
}
