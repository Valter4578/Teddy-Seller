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
    
    private var lastPlayedCell: CategoryFeedTableViewCell?
    
    var videoState: VideoState? {
        didSet {
            switch videoState {
            case .needsToLoad:
                self.loadVideos()
            case .loaded:
                break
            case .none:
                break
            case .prepareForLoad:
                break
            }
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
            self.configureCells()
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
    
    private var cells: [CategoryFeedTableViewCell] = []
    
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
        
        configureBottomBar()
        if needsToPresentBottomBar { setupBottomBar() }
        setupTableView()
        setupCategoryHeader()
        
        print(#function + "\(view.frame) - \(view.frame.width) - \(view.frame.size.width)")
    }
    
    // MARK:- Selectors
    @objc func didTapBack() {
        if let lastCell = lastPlayedCell {
            lastCell.productItem.videoContrainer.pausePlayer()
        }
        
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
            self.tableView.reloadData()
            
            videoState = .prepareForLoad
        }
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
        cells = []
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
    
    /// void method that adds cell to array to use this array in delegate methods
    private func configureCells() {
        guard !products.isEmpty else { return }
        
        let cell = CategoryFeedTableViewCell(superviewFrame: view.frame)
        cell.selectionStyle = .none
        
        tableView.register(CategoryFeedTableViewCell.self, forCellReuseIdentifier: cellId)
        
        for (index, product) in products.enumerated() {
            cell.productItem.videoContrainer.index = index
            cell.productItem.product = product
        }
        
        cells.append(cell)
    }
    
    /// void method that get cell and set player item to cell's avplayer. Need call only when cells on the screen 
    private func loadVideos() {
        cells.forEach { cell in
            guard let product = cell.productItem.product else { return }
            if let stringUrl = product.dictionary["video"] as? String, let videoUrl = URL(string: stringUrl) {
                cell.productItem.videoContrainer.delegate = self
                cell.productItem.videoContrainer.setPlayerURL(url: videoUrl)
            }
        }
        
        videoState = .loaded
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
        return cells[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // check if video didn't load
        if videoState != .loaded {
            // check if last cell displayed => all cell appeared
            if indexPath.row == cells.count - 1 {
                videoState = .needsToLoad
            }
        }
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
        if let lastCell = lastPlayedCell {
            lastCell.productItem.videoContrainer.pausePlayer()
        }
        
        self.lastCategory = currentCategory
        
        setupBottomBar()
        needsToPresentBottomBar = true
        
        self.currentCategory = category
       
        setupCategoryHeader()
        
        tableView.snp.remakeConstraints { (maker) in
            maker.leading.equalTo(view)
            maker.trailing.equalTo(view)
            maker.bottom.equalTo(bottomBar.snp.top)
        }
        
        videoState = .prepareForLoad
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
        let cell = cells[indexOfPlayer]
        print(cell.productItem.product?.title)
        
        guard cell != lastPlayedCell else { return } // check if last played cell is current playing cell. Because user can play one video twice
        
        // if user played video before (last played cell is nil)
        if let lastCell = lastPlayedCell {
            print(cell.productItem.product?.title)
            lastCell.productItem.videoContrainer.pausePlayer()
            lastPlayedCell = cells[indexOfPlayer] // last played cell now is current playing cell
            return
        }
        
        // if user play video for first time
        lastPlayedCell = cell
        return
    }
}
