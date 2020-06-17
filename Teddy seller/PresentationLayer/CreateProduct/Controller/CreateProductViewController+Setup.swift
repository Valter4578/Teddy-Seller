//
//  CreateProductViewController+Setup.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 08.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation 

extension CreateProductViewController {
    func setupAddButton() {
        view.addSubview(addButton)
        
        addButton.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.bottom.equalTo(view)
            $0.height.equalTo(78)
        }
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.clipsToBounds = false
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let leftItem = UIBarButtonItem(customView: arrowView)
        navigationItem.leftBarButtonItem = leftItem
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissCreateProduct))
        arrowView.addGestureRecognizer(gestureRecognizer)
        
        guard let name = category?.title.lowercased() else { return }
        title = "Добавить \(name)"
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = .clear
        
        tableView.allowsSelection = false
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { maker in
            maker.bottom.equalTo(addButton.snp.top)
            maker.leading.equalTo(view)
            maker.trailing.equalTo(view)
            maker.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupPickerView() {
        
        if let index = cellTypes.lastIndex(of: .textField(title: "Материал стен", serverName: "material", needsOnlyNumbers: false)) {
            materialsPickerView = UIPickerView()
            
            materialsPickerView?.delegate = self
            materialsPickerView?.dataSource = self
            
            guard let materialCell = cells[index] as? CreateProductTextFieldTableViewCell else { return }
            materialCell.textField.inputView = materialsPickerView
            materialsPickerView?.clipsToBounds = true 
        }
    }
}
