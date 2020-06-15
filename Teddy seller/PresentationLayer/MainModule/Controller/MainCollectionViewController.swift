//
//  MainCollectionViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 24.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation

final class MainCollectionViewController: UICollectionViewController {
    // MARK:- Views
    var arrowView: ArrowView = {
        let view = ArrowView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.transform = CGAffineTransform(rotationAngle: .pi)
        return view
    }()
    
    // MARK:- Properties
    let findCityViewController = FindCityViewController()

    var isFindCityPresented: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    var cityName: String = "Москва" {
        didSet {
            title = cityName
        }
    }
    
    let cellIdentifier = "MainCollectionViewCell"
    private let sectionInsets = UIEdgeInsets(top: 24.0,
                                             left: 33.0,
                                             bottom: 33.0,
                                             right: 31.0)
    
    var categories = [Category(imageName: "Realty", title: "Недвижимость",serverName: "Realty", isParent: true,
                               subcategories:
                            [Category(title: "Дома",serverName: "Houses",subcategories:
                                [Category(title: "1-этажные"),
                                 Category(title: "2-этажные"),
                                 Category(title: "3-этажные"),
                                 Category(title: "Многоэтажные")]),
                             Category(title: "Квартиры",serverName: "Flats", subcategories:
                             [Category(title: "1-комнатные"),
                              Category(title: "2-комнатные"),
                              Category(title: "3-комнтаные"),
                              Category(title: "Многокомнатные")]),
                             Category(title: "Комнаты", serverName: "Rooms"),
                            Category(title: "Участки", serverName: "Lands")]),
                      
                      Category(imageName: "Transport", title: "Автомобили",serverName: "Automobiles", isParent: true, subcategories:
                        [Category(title: "Легковые", serverName: "Cars"),
                         Category(title: "Спецтехника", serverName: "Machines"),
                         Category(title: "Грузовые", serverName: "Trucks"),
                         Category(title: "Мотоциклы", serverName: "Moto")]),
                      Category(imageName: "Home", title: "Для дома", serverName: "ForHouse", isParent: true),
                      Category(imageName: "Buiseness", title: "Для бизнеса", serverName: "ForBusiness", isParent: true),
                      Category(imageName: "Work", title: "Работа", serverName: "Job", isParent: true),
                      Category(imageName: "PersonalItems", title: "Личные вещи",serverName: "PersonalThings", isParent: true, subcategories:
                        [Category(title: "Одежда", serverName: "Clothes", subcategories:
                            [Category(title: "Куртки"),
                             Category(title: "Рубашки"),
                             Category(title: "Свитера"),
                             Category(title: "Джинсы"),
                             Category(title: "Футболки"),
                             Category(title: "Другое")]), Category(title: "Обувь", serverName: "Shoes"), Category(title: "Детские товары", serverName: "ForChildren"), Category(title: "Аксессуары", serverName: "Accessories"), Category(title: "Косметика", serverName: "Cosmetics"), Category(title: "Книги", serverName: "Books")]),
                      Category(imageName: "Electronics", title: "Электроника",serverName: "Electronix", isParent: true, subcategories:
                        [Category(title: "Мультимедиа", serverName: "Multimedia"),
                         Category(title: "Ноутбуки", serverName: "Laptops"),
                         Category(title: "Телефоны", serverName: "Phones"),
                         Category(title: "Оргтехника", serverName: "OfficeEquipment"),
                         Category(title: "Настольные ПК", serverName: "PC"),
                         Category(title: "Планшенты", serverName: "Pads"),
                         Category(title: "Фототехника", serverName: "Photo"),
                         Category(title: "Другое", serverName: "OtherElectronix")]),
                      Category(imageName: "Service", title: "Услуги", serverName: "OtherElectronix", isParent: true)]
    

    
    let locationManager = CLLocationManager()

    // MARK:- Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupStatusBar()
        setupNavigationBar()
        checkForToken()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        setupCollectionView()
        checkForToken()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setupStatusBar()
    }
            
    // MARK:- Selectors
    @objc func didTapNavigationBar() {
        findCityViewController.currentCity = cityName
        findCityViewController.delegate = self
        
        isFindCityPresented ? dissmisFindCity() : presentFindCity()
    }
    
    // MARK:- Private methods
    private func presentFindCity() {
        view.addSubview(self.findCityViewController.view)
        addChild(self.findCityViewController)
        self.findCityViewController.view.frame.origin.y += view.frame.height
        findCityViewController.view.clipsToBounds = true
        
        UIView.animate(withDuration: 0.7, animations: {
            self.findCityViewController.view.frame.origin.y = self.view.frame.origin.y
            self.arrowView.transform = CGAffineTransform(rotationAngle: 0)
        }) { _ in
            self.isFindCityPresented = true
        }
    }
    
    private func dissmisFindCity() {
        UIView.animate(withDuration: 0.7, animations: {
            self.findCityViewController.view.frame.origin.y += self.view.frame.height
            self.arrowView.transform = CGAffineTransform(rotationAngle: .pi)
        }) { _ in
            self.findCityViewController.view.removeFromSuperview()
            self.findCityViewController.removeFromParent()
            self.isFindCityPresented = false
        }
    }
    
    private func checkForToken() {
        let token = UserDefaults.standard.string(forKey: "token")
        
        print("------------------------------------------------")
        print(token)
        print("------------------------------------------------")
        
        let teddyService = TeddyAPIService()
        let mockCategory = Category(imageName: "Realty", title: "Недвижимость",serverName: "Realty")
        teddyService.getAds(for: mockCategory) { (result) in
            switch result {
            case .failure(let error):
                if error == .wrongToken {
                    let authViewController = AuthViewController()
                    authViewController.modalPresentationStyle = .fullScreen
                    self.present(authViewController, animated: true, completion: nil)
                }
            case .success(_):
                print("Success")
            }
        }
        
        if token == "" {
            let authViewController = AuthViewController()
            authViewController.modalPresentationStyle = .fullScreen
            present(authViewController, animated: true, completion: nil)
        }
        
        if let _ = token {} else {
            let authViewController = AuthViewController()
            authViewController.modalPresentationStyle = .fullScreen
            present(authViewController, animated: true, completion: nil)
        }
    }
    
    // MARK:- CollectionViewDatasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MainViewConllectionViewCell {
            cell.textLabel.text = categories[indexPath.item].title
            if let imageName = categories[indexPath.item].imageName {
                cell.iconImageView.image = UIImage(named: imageName)
            }
            cell.layer.cornerRadius = 24
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.borderGray.cgColor
            return cell
        }
        return UICollectionViewCell()
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let categoryFeeedViewController = CategoryFeedViewController()
        categoryFeeedViewController.selectedCategory = categories[indexPath.item]
        
        navigationController?.pushViewController(categoryFeeedViewController, animated: true)
    }
}

// MARK:- CollectionViewDelegateFlowLayout
extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * 3
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 2

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt: Int) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK:- CLLocationManagerDelegate
extension MainCollectionViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let cordinates: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        print(cordinates)
        let geocoderService = GeodecoderService()
        geocoderService.getCity(latitude: cordinates.latitude, longitude: cordinates.longitude) { (city) in
            self.cityName = city
        }
    }
}

// MARK:- FindCityViewControllerDelegate
extension MainCollectionViewController: FindCityViewControllerDelegate {
    func didDissmisBySave() {
        dissmisFindCity()
        arrowView.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    func setSelectedCity(cityName: String) {
        isFindCityPresented = false 
        self.cityName = cityName
    }
}
