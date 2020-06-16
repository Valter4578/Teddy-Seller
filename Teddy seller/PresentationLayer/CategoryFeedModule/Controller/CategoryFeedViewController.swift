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
    var switcherIndex: Int?
    var needsToPresentTopBar: Bool = false 
    var needsToPresentBottomBar: Bool = false {
        didSet {
            setupCollectionViewConstraints()
        }
    }
    
    var lastCategory: Category? = nil
    var selectedCategory: Category? {
        didSet {
            currentCategory = selectedCategory
        }
    }
    
    var currentCategory: Category? {
        didSet {
            title = currentCategory?.title
            getProducts()
            if let subcategories = currentCategory?.subcategories {
                header.subcategories = subcategories
                header.collectionView.reloadData()
            } else {
                header.subcategories = nil
                header.collectionView.reloadData()
            }
        }
    }
    
    var products: [Product] = []
    
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
    
    var collectionView: UICollectionView?
    
    var arrowView: ArrowView = {
        let view = ArrowView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.transform = CGAffineTransform(rotationAngle: -(.pi/2))
        return view
    }()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBack))
        arrowView.addGestureRecognizer(gestureRecognizer)
        
        setupNavigationBar()
        
        configureBottomBar()
        if needsToPresentBottomBar { setupBottomBar() }
        setupCollectionView()
        configureTopBar()
        setupCategoryHeader()
    }
    
    // MARK:- Selectors
    @objc func didTapBack() {
        if lastCategory == nil {
            navigationController?.popViewController(animated: true)
        } else {
            if currentCategory == lastCategory {
                lastCategory = selectedCategory
            }
            currentCategory = lastCategory
            if currentCategory?.isParent ?? true {
                lastCategory = nil
                needsToPresentBottomBar = false
            }
            
            setupCategoryHeader()
            self.collectionView?.reloadData()
        }
    }
    
    // MARK:- Private functions
    private func getProducts() {
        products = []
        collectionView?.reloadData()
        
        let teddyService = TeddyAPIService()
        
        guard let currentCategory = currentCategory else { return }
        
        teddyService.getAds(for: currentCategory) { [weak self] (result) in
            switch result {
            case .success(let product):
                print(product.title)
                self?.products.append(product)
                self?.collectionView?.reloadData()
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
        switch currentCategory?.title {
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
    
    private func configureBottomBar() {
        if currentCategory?.subcategories == nil {
            needsToPresentBottomBar = true
        }
    }
    
    // MARK:- Seletors
    @objc func presentCreate() {
        let createProductController = CreateProductViewController()
        createProductController.delegate = self
        createProductController.switcherValue = switcherIndex
        createProductController.category = currentCategory
        let navigationController = UINavigationController(rootViewController: createProductController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}

// MARK:- UICollectionViewDelegate
extension CategoryFeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.product = products[indexPath.item]
        navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension CategoryFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryFeedCollectionViewCell
        cell.layer.cornerRadius = 20
        
        if products.count != 0 {
            cell.product = products[indexPath.row]
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

// MARK:- TopBarDelegate
extension CategoryFeedViewController: TopBarDelegate {
    func passSelectedIndex(_ index: Int) {
        switcherIndex = index
    }
}

// MARK:- CategoryFeedHeaderDelegate
extension CategoryFeedViewController: CategoryFeedHeaderDelegate {
    func passSelectedCategory(_ category: Category) {
        self.lastCategory = currentCategory
        
        setupBottomBar()
        needsToPresentBottomBar = true
        
        self.currentCategory = category
       
        setupCategoryHeader()
        
        collectionView?.snp.remakeConstraints { (maker) in
            maker.leading.equalTo(view)
            maker.trailing.equalTo(view)
            maker.bottom.equalTo(bottomBar.snp.top)
        }
    }
}

// MARK:- CreateProductDelegate
extension CategoryFeedViewController: CreateProductDelegate {
    func didAddNewProduct() {
        getProducts()
    }
}
