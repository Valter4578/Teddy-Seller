//
//  FindCityViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 26.05.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

protocol FindCityViewControllerDelegate: class {
    func setSelectedCity(cityName: String)
    func didDissmisBySave()
}

class FindCityViewController: UIViewController {
    // MARK:- Private constants
    private let cellId = "FindCityViewControllerCell"
    private let headerId = "FindCityViewControllerHeader"
    
    // MARK:- Properties
    weak var delegate: FindCityViewControllerDelegate! 
    
    var foundedCities: [String] = ["Москва", "Санкт-Петербург", "Волгоград", "Владивосток", "Воронеж", "Екатеринбург", "Казань", "Калининград", "Краснодар", "Красноярск", "Красноярск", "Нижний Новгород", "Новосибирск", "Омск", "Пермь", "Ростов-на-Дону"]
    var standartCities: [String] = ["Москва", "Санкт-Петербург", "Волгоград", "Владивосток", "Воронеж", "Екатеринбург", "Казань", "Калининград", "Краснодар", "Красноярск", "Красноярск", "Нижний Новгород", "Новосибирск", "Омск", "Пермь", "Ростов-на-Дону"] {
        didSet {
            self.citiesTableView.alpha = 1 
        }
    }
    
    var currentCity: String = "Москва" {
        didSet {
            title = currentCity
        }
    }
    var cityToFind: String = ""
    var selectedCity: String = ""
    
    
    // MARK:- Views
    var header: FindCityHeader!
    
    var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainBlue
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.placeholderBlack, for: .normal)
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return button
    }()
    
    var citiesTableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = true
        
        return tableView
    }()
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.alpha = 0 
            
        setupSaveButton()
        setupTableView()

        setupNavigationBar()
        setupNotificationCenter()
        hideKeyboardByTapAround()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        navigationController?.navigationBar.alpha = 1
    }
    
    // MARK:- Private functions
    private func hideKeyboardByTapAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAround))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
    
    private func animateDissmis() {
        UIView.animate(withDuration: 0.7, animations: {
            self.view.alpha = 0
        }) { _ in
            self.view.removeFromSuperview()
            self.removeFromParent()
            self.willMove(toParent: nil)
        }
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
    
    @objc func editingDidEnd() {
        print(#function)
        guard let text = header.cityTextField.text else { return }
        if !text.isEmpty {
            foundedCities.removeAll()
            CityFinderService.getCities(city: text) { (city) in
                self.foundedCities.append(city)
                self.citiesTableView.reloadData()
            }
        } else {
            self.foundedCities = self.standartCities
            self.citiesTableView.reloadData()
        }
    }
    
    @objc func didTapSaveButton() {
        
        delegate.setSelectedCity(cityName: selectedCity)
        animateDissmis()
    }
    
    // MARK:- Setups
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.clipsToBounds = false
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapNavigationBar))
        navigationController?.navigationBar.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.cancelsTouchesInView = false
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
        citiesTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        if foundedCities.isEmpty {
            self.citiesTableView.alpha = 0
        }
        
        view.addSubview(citiesTableView)
        
        citiesTableView.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(saveButton.snp.top)
            maker.trailing.equalTo(view)
            maker.leading.equalTo(view)
            maker.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK:- UITableViewDelegate
extension FindCityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! FindCityHeader
        header.cityTextField.addTarget(self, action: #selector(editingDidEnd), for: .editingChanged)
        header.backgroundColor = .white
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        if !(foundedCities.isEmpty) {
            selectedCity = foundedCities[indexPath.row]
            header.cityTextField.text = selectedCity
        }
    }
}

// MARK:- UITableViewDataSource
extension FindCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundedCities.isEmpty ? standartCities.count : foundedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if !(foundedCities.isEmpty) {
            cell.textLabel?.text = foundedCities[indexPath.row]
        } else if foundedCities.isEmpty {
            cell.textLabel?.text = standartCities[indexPath.row]
        }
        cell.backgroundColor = .authNextGray
        return cell
    }
}
