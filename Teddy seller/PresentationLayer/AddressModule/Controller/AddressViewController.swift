//
//  AddressViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 14.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

protocol AddressDelegate: class {
    func passAddress(address: String)
}

class AddressViewController: UIViewController {
    // MARK:- Private properties
    private let cellId = "AddressViewControllerCell"
    private let fieldTitles = ["Регион", "Населённый пункт", "Район", "Улица", "Дом"]
    
    // MARK:- Properties
    weak var delegate: AddressDelegate!
    
    var cells: [UITableViewCell] = []
    
    // MARK:- Views
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        return tableView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainBlue
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name:"Helvetica Neue", size: 24)
        return button
    }()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Адрес"
        
        configureScreen()
        
        setupSaveButton()
        setupTableView()
        setupNavigationBar()
    }
    
    // MARK:- Private functions
    private func configureScreen() {
        for title in fieldTitles {
            let textFieldCell = TextFieldTableViewCell(style: .default, reuseIdentifier: cellId)
            textFieldCell.label.text = title
            tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: cellId)
            cells.append(textFieldCell)
            tableView.reloadData()
        }
    }
    
    // MARK:- Selectors
    @objc func didTapSaveButton() {
        var fullAddress = ""
        for cell in cells {
            guard let textFieldCell = cell as? TextFieldTableViewCell,
                let text = textFieldCell.textField.text else { return }
            
            fullAddress += text + " "
        }
        
        delegate.passAddress(address: fullAddress)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Setups
    private func setupTableView() {
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide)
            maker.leading.equalTo(view)
            maker.trailing.equalTo(view)
            maker.bottom.equalTo(saveButton.snp.top)
        }
    }
    
    private func setupSaveButton() {
        view.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { maker in
            maker.leading.equalTo(view)
            maker.trailing.equalTo(view)
            maker.bottom.equalTo(view)
            maker.height.equalTo(78)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
    }
}

// MARK:- UITableViewDataSource
extension AddressViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }
}
