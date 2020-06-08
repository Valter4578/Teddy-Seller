//
//  CategoryFeedViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class CategoryFeedViewController: UIViewController {
    // MARK:- Private properties
    let cellId = "CategoryFeedCollectionViewControllerCellId"
    let headerId = "CategoryFeedCollectionViewHeaderId"
    
    // To pass selected cell's index path to didTapContact
    private var selectedIndexPath: IndexPath?
    
    // MARK:- Properties
    
    var needsToPresentTopBar: Bool = false 
    
    var category: Category?
    var products: [Product]? = [] {
        didSet {
            print(products)
        }
    }
    
    // MARK:- Views
    var header: CategoryFeedHeader = {
        let layout = UICollectionViewFlowLayout()
        let header = CategoryFeedHeader(collectionViewLayout: layout)
        return header
    }()
    
    var bottomBar: BottomBar = {
        let bar = BottomBar()
        bar.plusContainer.addTarget(self, action: #selector(presentCreate), for: .touchUpInside)
        return bar
    }()
    
    var topBar: TopBar = TopBar()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .mainBlue
        return collectionView
    }()
    
    var arrowView: ArrowView = {
        let view = ArrowView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.transform = CGAffineTransform(rotationAngle: -(.pi/2))
        return view
    }()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBack))
        arrowView.addGestureRecognizer(gestureRecognizer)
        
        setupNavigationBar()
        setupBottomBar()
        setupCollectionView()
        configureTopBar()
        setupCategoryHeader()
        getProducts()
    }
    
    // MARK:- Selectors
    @objc func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Private functions
    private func getProducts() {
        let teddyService = TeddyAPIService()
        
        guard let serverName = category?.serverName else { return }
        
        teddyService.getAds(for: serverName) { [weak self] (result) in
            switch result {
            case .success(let product):
                print(product.title)
                self?.products?.append(product)
                self?.collectionView.reloadData()
            case .failure(let error):
                if error == .wrongToken {
                    let authController = AuthViewController()
                    authController.modalPresentationStyle = .fullScreen
                    self?.present(authController, animated: true)
                }
                
                let adsAlertBuilder = AdsAlertBuilder(errorType: error)
                adsAlertBuilder.configureAlert { alert in
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    private func configureTopBar() {
        switch category?.title {
        case "Одежда":
            setupTopBar(leftTitle: "Мужская", rightTitle: "Женская")
            needsToPresentTopBar = true
        case "Работа":
            setupTopBar(leftTitle: "Вакансии", rightTitle: "Резюме")
            needsToPresentTopBar = true
        case "Недвижимость":
            setupTopBar(leftTitle: "Снять", rightTitle: "Купить")
            needsToPresentTopBar = true
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    // MARK:- Seletors
    @objc func presentCreate() {
        print(#function)
    }
}

// MARK:- UICollectionViewDelegate
extension CategoryFeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products?[indexPath.item]
        
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.product = product
        navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension CategoryFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let prdcts = products else { return 0 }
        return prdcts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryFeedCollectionViewCell
        cell.layer.cornerRadius = 20
        
        if let product = products?[indexPath.item] {
            cell.product = product
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function)
        selectedIndexPath = indexPath
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension CategoryFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 38, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension CategoryFeedViewController: TopBarDelegate {
    func passSelectedIndex(_ index: Int) {
        print(index)
    }
}
