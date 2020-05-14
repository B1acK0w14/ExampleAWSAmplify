//
//  ViewConfiguration.swift
//  ExampleAWSAmplify
//
//  Created by David Andres Penagos Sanchez on 12/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import Foundation

public protocol ViewConfiguration: AnyObject {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
    func setupViewConfiguration()
}

public extension ViewConfiguration {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func configureViews() {
    }
}
