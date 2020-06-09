//
//  CreateProductViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 08.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class CreateProductViewController: UIViewController {
    // MARK:- Properties
    var category: Category?
    
    var cells: [UITableViewCell]? {
        didSet {
            print(cells)
        }
    }
    
    // MARK:- Views
    var arrowView: ArrowView = {
        let view = ArrowView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.transform = CGAffineTransform(rotationAngle: -(.pi/2))
        return view
    }()
    
    var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainBlue
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.placeholderBlack, for: .normal)
        return button
    }()
    
    var tableView: UITableView = UITableView()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupAddButton()
        setupTableView() 
        setupNavigationBar()
    }
    
    // MARK:- Private functions
    private func configureScreen() {
//        switch category?.title {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
    }
}

// MARK:- UITableViewDelegate
extension CreateProductViewController: UITableViewDelegate {
    
}

// MARK:- UITableViewDataSource
extension CreateProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells?[indexPath.item] ?? UITableViewCell()
    }
}
