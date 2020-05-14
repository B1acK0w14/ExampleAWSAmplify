//
//  HomeViewController.swift
//  ExampleAWSAmplify
//
//  Created by David Andres Penagos Sanchez on 14/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import UIKit
import AWSMobileClient
import MapKit

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var homeView: HomeView = {
        let view = HomeView(delegate: self)
        return view
    }()
    
    var locationManager: CLLocationManager?
    
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
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: - Extensions
extension HomeViewController: HomeDelegate {
    
    func logoutUser() {
        self.navigationController?.popToRootViewController(animated: true)
        AWSMobileClient.default().signOut()
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.homeView.mapView.showsUserLocation = true
            self.homeView.mapView.setRegion(region, animated: true)
        }
        
    }
}
