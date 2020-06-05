//
//  Main+Setup.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import CoreLocation

extension MainCollectionViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.clipsToBounds = false
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    
        let rightItem = UIBarButtonItem(customView: arrowView)
        navigationItem.rightBarButtonItem = rightItem
        
        title = cityName
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapNavigationBar))
        navigationController?.navigationBar.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupStatusBar() {
        let customStatusBar =  UIView()
        customStatusBar.frame = UIApplication.shared.statusBarFrame
        customStatusBar.backgroundColor = .black
        UIApplication.shared.keyWindow?.addSubview(customStatusBar)
    }
    
    func setupCollectionView() {
        collectionView.register(MainViewConllectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundView = UIView()
        collectionView.backgroundView?.addGradient(to: collectionView.frame)
    }
    
    func setupLocationManager() {
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}
