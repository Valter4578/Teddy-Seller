//
//  CategoryFeedViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 02.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

enum VideoState {
    /// video is loaded and user can see them on the screen
    case loaded
    /// when products added but loadVideo() didn't execute
    case needsToLoad
    /// when category changed
    case prepareForLoad
}

final class CategoryFeedViewController: UIViewController {
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
    
//    private var lastPlayedCell: CategoryFeedTableViewCell?
    /// index path for last played cell
    private var lastPlayedCellIndexPath: IndexPath?
    
    // MARK:- Properties
    var switcherIndex: Int? = 0 {
        didSet {
            getProducts()
        }
    }
    
    var needsToPresentTopBar: Bool = false 
    var needsToPresentBottomBar: Bool = false {
        didSet {
            setupTableViewConstraints()
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
    
    
    var products: [Product] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
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
    
    var tableView: UITableView = UITableView() 
    
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
        
        if needsToPresentTopBar {
            setupTopBar(leftTitle: leftTopBarTitle ?? "", rightTitle: rightTopBarTitle ?? "")
        }
        
        if needsToPresentBottomBar { setupBottomBar() }
        configureBottomBar()
        setupTableView()
        setupCategoryHeader()
        
        print(#function + "\(view.frame) - \(view.frame.width) - \(view.frame.size.width)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData() 
    }
    
    // MARK:- Selectors
    @objc func didTapBack() {
            navigationController?.popViewController(animated: true)
    }
    
    @objc func presentCreate() {
        let createProductController = CreateProductViewController()
        createProductController.delegate = self
        
        if let barServerName = topBarServerName {
            createProductController.switcherServerName = barServerName
            createProductController.switcherValue = switcherIndex
        }
        
        createProductController.category = currentCategory
        
        let navigationController = UINavigationController(rootViewController: createProductController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    @objc func presentSearch() {
        let searchViewController = SearchViewController()
        searchViewController.category = currentCategory
        
        navigationController?.pushViewController(searchViewController, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    // MARK:- Private functions
    private func getProducts() {
        products = []
        tableView.reloadData()
        
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
                guard let strongSelf = self else { return }
                print(product.title)
                strongSelf.products.append(product)
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
                return
            }
        }
    }
    
    private func configureTopBar() {
        switch currentCategory?.title {
        case "Одежда":
            
            leftTopBarTitle = "Мужская"
            rightTopBarTitle = "Женская"
            needsToPresentTopBar = true
        case "Работа":
            topBarServerName = "jobOrVacancy" // потом поменяю на актуальное название, которое лежит на сервере
            leftTopBarTitle = "Вакансии"
            rightTopBarTitle = "Резюме"
            needsToPresentTopBar = true
        case "Недвижимость":
            topBarServerName = "rentOrBuy"
            leftTopBarTitle = "Снять"
            rightTopBarTitle = "Купить"
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

// MARK:- UITableViewDelegate
extension CategoryFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.product = products[indexPath.row]
        navigationController?.pushViewController(productDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
}

// MARK: UICollectionViewDataSource
extension CategoryFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CategoryFeedTableViewCell
        
        cell.selectionStyle = .none
        
        cell.productItem.product = products[indexPath.row]
        cell.productItem.videoContainer.index = indexPath.row
        cell.productItem.videoContainer.delegate = self
        
        cell.configureCell()
        
        return cell 
//        return cells[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
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
        products = [] 
        
        let categoryFeedViewController = CategoryFeedViewController()
        categoryFeedViewController.currentCategory = category
        categoryFeedViewController.needsToPresentBottomBar = true

        navigationController?.pushViewController(categoryFeedViewController, animated: true)
    }
}

// MARK:- CreateProductDelegate
extension CategoryFeedViewController: CreateProductDelegate {
    func didAddNewProduct() {
        getProducts()
    }
}

extension CategoryFeedViewController: PlayerViewDelegate {
    func didTapOnButton(indexOfPlayer: Int) {
        
    }
}
