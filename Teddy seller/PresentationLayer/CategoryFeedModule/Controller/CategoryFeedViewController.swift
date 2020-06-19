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
    
    private var isSe: Bool? {
        didSet {
            header.isSe = isSe
        }
    }
    
    // MARK:- Properties
    var switcherIndex: Int? = 0 {
        didSet {
            getProducts()
        }
    }
    var needsToPresentTopBar: Bool = false 
    var needsToPresentBottomBar: Bool = false {
        didSet {
            if let _ = collectionView {
                setupCollectionViewConstraints()
            }
        }
    }
    
    // сategories
    var lastCategory: Category? = nil
    var selectedCategory: Category? {
        didSet {
            currentCategory = selectedCategory
        }
    }
    
    var currentCategory: Category? {
        didSet {
            configureTopBar()
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
    
    // top bar
    var leftTopBarTitle: String?
    var rightTopBarTitle: String?
    var topBarServerName: String? // last property for search json in /addAd methods
    
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
                
        checkForSe() 
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBack))
        arrowView.addGestureRecognizer(gestureRecognizer)
        
        setupNavigationBar()
        
        configureBottomBar()
        if needsToPresentBottomBar { setupBottomBar() }
        setupCollectionView()
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
    
    @objc func presentCreate() {
        let createProductController = CreateProductViewController()
        createProductController.delegate = self
        createProductController.switcherValue = switcherIndex
        createProductController.category = currentCategory
        createProductController.switcherServerName = topBarServerName
        createProductController.switcherValue = switcherIndex
        let navigationController = UINavigationController(rootViewController: createProductController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    // MARK:- Private functions
    private func getProducts() {
        products = []
        collectionView?.reloadData()
        
        let teddyService = TeddyAPIService()
        
        guard let currentCategory = currentCategory else { return }
        
        guard let userCity = UserDefaults.standard.string(forKey: "userCity") else { return }
        var searchJsonParametrs: [String: Any] = [
            "city": userCity
        ]
        
        if let serverName = topBarServerName, serverName != "", let index = switcherIndex {
            let stringIndex = String(index)
            searchJsonParametrs.updateValue(stringIndex, forKey: serverName)
        }
        
        var json = JSONBuilder.createJSON(parametrs: searchJsonParametrs)
        
        teddyService.getAds(for: currentCategory, searchJson: json) { [weak self] (result) in
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
             
            leftTopBarTitle = "Мужская"
            rightTopBarTitle = "Женская"
            setupTopBar(leftTitle: leftTopBarTitle ?? "", rightTitle: rightTopBarTitle ?? "")
            needsToPresentTopBar = true
        case "Работа":
            leftTopBarTitle = "Вакансии"
            rightTopBarTitle = "Резюме"
            setupTopBar(leftTitle: leftTopBarTitle ?? "", rightTitle: rightTopBarTitle ?? "")
            needsToPresentTopBar = true
        case "Недвижимость":
            topBarServerName = "rentOrBuy"
            leftTopBarTitle = "Снять"
            rightTopBarTitle = "Купить"
            setupTopBar(leftTitle: leftTopBarTitle ?? "", rightTitle: rightTopBarTitle ?? "")
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
    
    private func checkForSe() {
        let modelName = UIDevice.modelName
        
        if modelName == "iPhone SE" || modelName == "Simulator iPhone SE" {
            isSe = true
        } else {
            isSe = false
        }
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
        
        cell.product = products[indexPath.row]
        
        if let stringUrl = products[indexPath.row].dictionary["video"] as? String, let videoUrl = URL(string: stringUrl) {
            cell.videoContrainer.setPlayerURL(url: videoUrl)
            cell.videoContrainer.player.play()
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
