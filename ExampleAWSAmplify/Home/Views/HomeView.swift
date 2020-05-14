//
//  HomeView.swift
//  ExampleAWSAmplify
//
//  Created by David Andres Penagos Sanchez on 14/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import UIKit
import MapKit

class HomeView: UIView {
    
    //MARK: - Properties
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.init(rgb: 0xf77e7e)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 0.4, bottom: 0, right: 0.4)
        button.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelInfoHome: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = NSTextAlignment.justified
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Welcome to this amazing app! We made it with AWS! Cool, ha?"
        return label
    }()
    
    public lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.layer.borderWidth = 1
        map.layer.borderColor = UIColor.black.cgColor
        return map
    }()
    
    weak var delegate: HomeDelegate?
    
    //MARK: - Init
    init(delegate: HomeDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func logoutUser() {
        self.delegate?.logoutUser()
    }
}

extension HomeView: ViewConfiguration {
    
    func configureViews() {
        backgroundColor = .white
    }
    
    func buildViewHierarchy() {
        self.addSubview(logoutButton)
        self.addSubview(labelInfoHome)
        self.addSubview(mapView)
    }
    
    func setupConstraints() {
        logoutButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.topMargin.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        labelInfoHome.snp.makeConstraints { (make) in
            make.height.equalTo(80)
            make.topMargin.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(67)
            make.trailing.equalToSuperview().offset(-67)
        }
        
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(labelInfoHome.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottomMargin.equalToSuperview().offset(-20)
        }
    }
}
