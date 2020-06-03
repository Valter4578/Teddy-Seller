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
        let view = ArrowView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
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
    
//    var categories = [MainCellModel(imageName: "Realty", text: "Недвижимость", category: .realty),
//                      MainCellModel(imageName: "Transport", text: "Транспорт", category: .transport),
//                      MainCellModel(imageName: "Home", text: "Для дома", category: .home),
//                      MainCellModel(imageName: "Buiseness", text: "Для бизнеса", category: .buisness),
//                      MainCellModel(imageName: "Work", text: "Работа", category: .work),
//                      MainCellModel(imageName: "PersonalItems", text: "Личные вещи", category: .personalItems),
//                      MainCellModel(imageName: "Electronics", text: "Электроника", category: .electronics),
//                      MainCellModel(imageName: "Service", text: "Услуги", category: .service),]
    
    var categories = [Category(imageName: "Realty", title: "Недвижимость",
                               subcategories:
                                [Category(imageName: nil, title: "Дома", subcategories:
                                [Category(imageName: nil, title: "1-этажные", subcategories: nil),
                                 Category(imageName: nil, title: "2-этажные", subcategories: nil),
                                 Category(imageName: nil, title: "3-этажные", subcategories: nil),
                                 Category(imageName: nil, title: "Многоэтажные", subcategories: nil)])]),
                      Category(imageName: "Transport", title: "Автомобили", subcategories:
                            [Category(imageName: nil, title: "Легковые", subcategories: nil),
                             Category(imageName: nil, title: "Спецтехника", subcategories: nil),
                             Category(imageName: nil, title: "Грузовые", subcategories: nil),
                             Category(imageName: nil, title: "Мотоциклы", subcategories: nil)]),
                      Category(imageName: "Home", title: "Для дома", subcategories: nil),
                      Category(imageName: "Buiseness", title: "Для бизнеса", subcategories: nil),
                      Category(imageName: "Work", title: "Работа", subcategories: nil),
                      Category(imageName: "PersonalItems", title: "Личные вещи", subcategories:
                        [Category(imageName: nil, title: "Одежда", subcategories:
                            [Category(imageName: nil, title: "Куртки", subcategories: nil),
                             Category(imageName: nil, title: "Рубашки", subcategories: nil),
                             Category(imageName: nil, title: "Свитера", subcategories: nil),
                             Category(imageName: nil, title: "Джинсы", subcategories: nil),
                             Category(imageName: nil, title: "Футболки", subcategories: nil),
                             Category(imageName: nil, title: "Другое", subcategories: nil)])]),
                      Category(imageName: "Electronics", title: "Электроника", subcategories:
                        [Category(imageName: nil, title: "Мультимедиа", subcategories: nil),
                         Category(imageName: nil, title: "Ноутбуки", subcategories: nil),
                         Category(imageName: nil, title: "Телефоны", subcategories: nil),
                         Category(imageName: nil, title: "Оргтехника", subcategories: nil),
                         Category(imageName: nil, title: "Настольные ПК", subcategories: nil),
                         Category(imageName: nil, title: "Планшенты", subcategories: nil),
                         Category(imageName: nil, title: "Фототехника", subcategories: nil), Category(imageName: nil, title: "Другое", subcategories: nil)]), Category(imageName: "Service", title: "Услуги", subcategories: nil)]
    

    
    let locationManager = CLLocationManager()

    // MARK:- Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupStatusBar()
        setupNavigationBar()
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
        findCityViewController.view.clipsToBounds = true
        findCityViewController.view.alpha = 0
        
        UIView.animate(withDuration: 0.7, animations: {
            self.findCityViewController.view.alpha = 1
            self.arrowView.transform = CGAffineTransform(rotationAngle: 0)
        }) { _ in
            self.isFindCityPresented = true
        }
    }
    
    private func dissmisFindCity() {
        UIView.animate(withDuration: 0.7, animations: {
            self.findCityViewController.view.alpha = 0
            self.arrowView.transform = CGAffineTransform(rotationAngle: .pi)
        }) { _ in
            self.findCityViewController.view.removeFromSuperview()
            self.findCityViewController.removeFromParent()
            self.findCityViewController.willMove(toParent: nil)
            self.isFindCityPresented = false
        }
    }
    
    private func checkForToken() {
        let token = UserDefaults.standard.string(forKey: "token")
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
    
//    private func getSubcategories(for indexPath: IndexPath) -> [String]? {
////        switch categories[indexPath.row].category {
////        case .electronics:
////            return ["Мультимедиа", "Ноутбуки", "Телефоны", "Оргтехника", "Настольные ПК", "Планшеты", "Фототехника", "Другое"]
////        case .transport:
////            return ["Легковые", "Спецтехнкиа", "Грузовые", "Мотоциклы"]
////        case .personalItems:
////            return ["Одежда", "Детские товары", "Косметика"]
////        default:
////            return nil
////        }
//    }
    
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
        let categoryFeeedViewController = CategoryFeedCollectionViewController(collectionViewLayout: layout)
//        categoryFeeedViewController.category = categories[indexPath.item].category
//        categoryFeeedViewController.subcategories = getSubcategories(for: indexPath)
        
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
        arrowView.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    func setSelectedCity(cityName: String) {
        isFindCityPresented = false 
        self.cityName = cityName
    }
}
