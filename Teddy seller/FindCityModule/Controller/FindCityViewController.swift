//
//  FindCityViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 26.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class FindCityViewController: UIViewController {
    // MARK:- Private constants
    private let cellId = "FindCityViewControllerCell"
    private let headerId = "FindCityViewControllerHeader"
    
    // MARK:- Properties
    var foundedCities: [String] = []
    var currentCity: String = "Москва" {
        didSet {
            title = currentCity
        }
    }
    
    // MARK:- Views
    var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainBlue
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.placeholderBlack, for: .normal)
        return button
    }()
    
    var citiesTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSaveButton()
        setupTableView()
        setupNavigationBar()
        setupNotificationCenter()
        hideKeyboardByTapAround()
        
    }
    
    // MARK:- Private functions
    private func hideKeyboardByTapAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAround))
        view.addGestureRecognizer(tap)
    }
    
    // MARK:- Selectors
    @objc func didTapAround() {
           view.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.saveButton.snp.remakeConstraints { (maker) in
                maker.leading.equalTo(view)
                maker.trailing.equalTo(view)
                maker.bottom.equalTo(view).offset(-keyboardHeight)
                maker.height.equalTo(78)
            }
        }
    }
    
    @objc func keyboardWillHide(sender: Notification) {
        saveButton.snp.remakeConstraints { (maker) in
            maker.leading.equalTo(view)
            maker.trailing.equalTo(view)
            maker.bottom.equalTo(view)
            maker.height.equalTo(78)
        }
    }
    
    @objc func didTapNavigationBar() {
        dismiss(animated: true, completion: nil)
    }

    // MARK:- Setups
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapNavigationBar))
        navigationController?.navigationBar.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupSaveButton() {
        view.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { (maker) in
            maker.leading.equalTo(view)
            maker.trailing.equalTo(view)
            maker.bottom.equalTo(view)
            maker.height.equalTo(78)
        }
    }
    
    private func setupTableView() {
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        
        citiesTableView.register(FindCityHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        
        citiesTableView.backgroundColor = .white
        
        view.addSubview(citiesTableView)
        
        citiesTableView.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(saveButton.snp.top)
            maker.trailing.equalTo(view)
            maker.leading.equalTo(view)
            maker.top.equalTo(view)
        }
    }
}

// MARK:- UITableViewDelegate
extension FindCityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! FindCityHeader
        header.backgroundColor = .white
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
}

// MARK:- UITableViewDataSource
extension FindCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = foundedCities[indexPath.row]
        cell.backgroundColor = .authNextGray
        return cell
    }
}
