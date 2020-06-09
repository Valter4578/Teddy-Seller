//
//  CreateProductViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 08.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class CreateProductViewController: UIViewController {
    // MARK:- Private properties
    private let videoCellId = "CreateProductViewControllerVideoCell"
    private let textFieldCellId = "CreateProductViewControllerTextFieldCell"
    private let textViewCellId = "CreateProductViewControllerTextViewCell"
    
    // MARK:- Properties
    var cellTypes: [CreateProductCellType] = []
    var category: Category?
    
    var cells: [UITableViewCell] = [] {
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
     
        configureScreen() 
        
        setupAddButton()
        setupTableView() 
        setupNavigationBar()
    }
    
    // MARK:- Private functions
    private func configureScreen() {
        cellTypes.forEach {
            switch $0 {
            case .video(let title):
                let videoCell = CreateProductVideoTableViewCell(style: .default, reuseIdentifier: videoCellId)
                tableView.register(CreateProductVideoTableViewCell.self, forCellReuseIdentifier: videoCellId)
                print(title)
                cells.append(videoCell)
                tableView.rowHeight = 300
                tableView.reloadData()
                
            case .textField(let title):
                let textFieldCell = CreateProductTextFieldTableViewCell(style: .default, reuseIdentifier: textFieldCellId)
                tableView.register(CreateProductTextFieldTableViewCell.self, forCellReuseIdentifier: textFieldCellId)
                print(title)
                cells.append(textFieldCell)
                tableView.rowHeight = 125
                tableView.reloadData()
            case .textView(let title):
                let textViewCell = CreateProductTextViewTableViewCell(style: .default, reuseIdentifier: textViewCellId)
                tableView.register(CreateProductTextViewTableViewCell.self, forCellReuseIdentifier: textViewCellId)
                print(title)
                cells.append(textViewCell)
                tableView.rowHeight = 260

                tableView.reloadData()
            }
        }
    }
    
    // MARK:- Selectors
    @objc func dismissCreateProduct() {
        dismiss(animated: true)
    }
}

// MARK:- UITableViewDelegate
extension CreateProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellTypes[indexPath.row] {
        case .textField(_): return 88
        case .video(_): return 225
        case .textView(_): return 225
        }
    }
}

// MARK:- UITableViewDataSource
extension CreateProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.item]
    }
}
