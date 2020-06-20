//
//  SearchViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 20.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK:- Properties
    var cells: [UITableViewCell] = []
    
    // MARK:- Views
    let findButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainBlue
        button.setTitle("Найти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let tableView = UITableView()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFindButton()
        setupTableView()
    }
    
    // MARK:- Functions
    
    
    // MARK:- Private functions
    
    // MARK:- Selectors
    
    
}

// MARK:- UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
}

// MARK:- UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }
}
