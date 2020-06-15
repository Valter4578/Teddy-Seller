//
//  CreateProductViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 08.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

protocol CreateProductDelegate: class {
    func didAddNewProduct()
}

class CreateProductViewController: UIViewController {
    // MARK:- Private properties
    let videoCellId = "CreateProductViewControllerVideoCell"
    let textFieldCellId = "CreateProductViewControllerTextFieldCell"
    let textViewCellId = "CreateProductViewControllerTextViewCell"
    
    private let materials = ["деревянный", "кирпичный", "блочный", "панельный"]
    
    // MARK:- Properties
    weak var delegate: CreateProductDelegate!
    
    var switcherValue: Int?
    var cellTypes: [CreateProductCellType] = []
    var category: Category? {
        didSet {
            configureCellTypes()
        }
    }
    
    var cells: [UITableViewCell] = []
    
    // MARK:- Views
    var arrowView: ArrowView = {
        let view = ArrowView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.transform = CGAffineTransform(rotationAngle: -(.pi/2))
        return view
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainBlue
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name:"Helvetica Neue", size: 24)
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        return button
    }()
    
    var tableView: UITableView = UITableView()
    
    var materialsPickerView: UIPickerView?
    
    let findCityViewController = FindCityViewController()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureCells()
        
        setupAddButton()
        setupTableView() 
        setupNavigationBar()
        setupPickerView()
    }
    
    // MARK:- Private functions
    private func hideKeyboardByTapAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAround))
        view.addGestureRecognizer(tap)
    }
    
    private func addProduct(json: String) {
        let teddyService = TeddyAPIService()
        teddyService.addProduct(json: json) { result in
            switch result {
            case .success(let id):
                print(id)
                self.delegate.didAddNewProduct()
                self.dismiss(animated: true)
            case .failure(let error):
                let alertBuilder = AddAdAlertBuilder(errorType: error)
                alertBuilder.configureAlert { alert in
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    // MARK:- Selectors
    @objc func dismissCreateProduct() {
        dismiss(animated: true)
    }
    
    @objc func didTapAddButton() {
        var jsonParametrs: [String: Any] = [:]
        for i in 0...cells.count - 1 {
            if let videoCell = cells[i] as? CreateProductVideoTableViewCell {
                print("\(videoCell.serverName) -- \(videoCell.label.text)")
            }
            
            if let textViewCell = cells[i] as? CreateProductTextViewTableViewCell {
                print("\(textViewCell.serverName) -- \(textViewCell.textView.text)")
                guard let serverName = textViewCell.serverName else { return }
                jsonParametrs.updateValue(textViewCell.textView.text, forKey: serverName)
            }
            
            if let textFieldCell = cells[i] as? CreateProductTextFieldTableViewCell {
                print("\(textFieldCell.serverName) -- \(textFieldCell.textField.text)")
                guard let serverName = textFieldCell.serverName else { continue }
                jsonParametrs.updateValue(textFieldCell.textField.text, forKey: serverName)
            }
        }
        
        if category?.title == "Автомобили" {
            guard let mark = jsonParametrs["mark"] as? String,
                let model = jsonParametrs["model"] as? String
                else { return }
            let productTitle = "\(mark) \(model)"
            jsonParametrs.updateValue(productTitle, forKey: "title")
        }
        
        jsonParametrs.updateValue(category?.serverName, forKey: "subcategory")
        
        let json = JSONBuilder.createJSON(parametrs: jsonParametrs)
        addProduct(json: json)
    }
    
    @objc func keyboardWillShow(sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y = -keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    /// Hide keyboard by tap everywhere on screen
    @objc func didTapAround() {
        view.endEditing(true)
    }
    
    @objc func didTapOnVideoContainer() {
        print(#function)
        // функционал добавления видео добавлю позднее 
    }
    
    @objc func didTapAddressTextView() {
        let addressController = AddressViewController()
        addressController.delegate = self
        navigationController?.pushViewController(addressController, animated: true)
    }
    
    @objc func presentFindCity() {
        findCityViewController.delegate = self
        view.addSubview(findCityViewController.view)
        addChild(findCityViewController)
        findCityViewController.view.frame.origin.y += view.frame.height
        findCityViewController.view.clipsToBounds = true
        
        UIView.animate(withDuration: 0.7) {
            self.findCityViewController.view.frame.origin.y = self.view.frame.origin.y
        }
    }
}

// MARK:- UITableViewDelegate
extension CreateProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellTypes[indexPath.row] {
        case .textField(_): return 105
        case .video(_): return 235
        case .textView(_): return 235
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

// MARK:- UIPickerViewDelegate
extension CreateProductViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let indexOfCell = cellTypes.lastIndex(of: .textField(title: "Материал стен", serverName: "material", needsOnlyNumbers: false)),
            let materialCell = cells[indexOfCell] as? CreateProductTextFieldTableViewCell else { return }
        materialCell.textField.text = materials[row]
    }
}

// MARK:- UIPickerViewDataSource
extension CreateProductViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return materials.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return materials[row]
    }
}

// MARK:- AddressDelegate
extension CreateProductViewController: AddressDelegate {
    func passAddress(address: String) {
        if let index = cellTypes.firstIndex(of: .textView(title: "Адрес", serverName: "address")) {
            guard let addressCell = cells[index] as? CreateProductTextViewTableViewCell else { return }
            addressCell.textView.text = address
        }
    }
}

// MARK:- FindCityViewControllerDelegate
extension CreateProductViewController: FindCityViewControllerDelegate {
    func setSelectedCity(cityName: String) {
        if let indexOfCityCell = cellTypes.firstIndex(of: .textField(title: "Город", serverName: "city", needsOnlyNumbers: false)) {
            guard let cityCell = cells[indexOfCityCell] as? CreateProductTextFieldTableViewCell else { return }
            cityCell.textField.text = cityName
        }
    }
    
    func didDissmisBySave() {
        UIView.animate(withDuration: 0.7, animations: {
            self.findCityViewController.view.frame.origin.y += self.view.frame.height
        }) { _ in
            self.findCityViewController.view.removeFromSuperview()
            self.findCityViewController.removeFromParent()
        }
    }
}
