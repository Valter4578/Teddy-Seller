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
    
    private let materials = ["деревянный", "кирпичный", "блочный", "панельный"]
    
    // MARK:- Properties
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
        let view = ArrowView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
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
    
    private func configureCells() {
        cellTypes.forEach {
            switch $0 {
            case .video(let title, let serverName):
                let videoCell = CreateProductVideoTableViewCell(style: .default, reuseIdentifier: videoCellId)
                videoCell.label.text = title
                videoCell.serverName = serverName
                tableView.register(CreateProductVideoTableViewCell.self, forCellReuseIdentifier: videoCellId)
                cells.append(videoCell)
                tableView.rowHeight = 300
                tableView.reloadData()
                
            case .textField(let title, let serverName):
                let textFieldCell = CreateProductTextFieldTableViewCell(style: .default, reuseIdentifier: textFieldCellId)
                textFieldCell.label.text = title
                textFieldCell.serverName = serverName
                tableView.register(CreateProductTextFieldTableViewCell.self, forCellReuseIdentifier: textFieldCellId)
                print(title)
                cells.append(textFieldCell)
                tableView.rowHeight = 125
                tableView.reloadData()
            case .textView(let title, let serverName):
                let textViewCell = CreateProductTextViewTableViewCell(style: .default, reuseIdentifier: textViewCellId)
                textViewCell.label.text = title
                textViewCell.serverName = serverName
                tableView.register(CreateProductTextViewTableViewCell.self, forCellReuseIdentifier: textViewCellId)
                print(title)
                cells.append(textViewCell)
                tableView.rowHeight = 260

                tableView.reloadData()
            }
        }
    }

    func configureCellTypes() {
        switch category?.title {
        case "Автомобили":
            cellTypes = [.video(title: "Видео", serverName: "video"), .textField(title: "Марка", serverName: "mark"), .textField(title: "Модель", serverName: "model"), .textField(title: "Цена", serverName: "price"), .textField(title: "Год выпуска", serverName: "year"), .textField(title: "Пробег", serverName: "mileage"), .textView(title: "Описание", serverName: "description")]
        case "Электроника":
            cellTypes = [.textField(title: "Название товара", serverName: "title"), .video(title: "Видео", serverName: "video"), .textField(title: "Марка", serverName: "mark"), .textField(title: "Модель", serverName: "model"), .textField(title: "Цена", serverName: "price"), .textField(title: "Год выпуска", serverName: "year"), .textView(title: "Описание", serverName: "description")]
        case "Комната":
            cellTypes = [.textField(title: "Название объявления", serverName: "title"), .video(title: "Видео", serverName: "video"), .textView(title: "Адрес", serverName: "address"), .textField(title: "Цена", serverName: "price"), .textField(title: "Площадь, м2", serverName: "square")]
        case "Участки":
            cellTypes = [.textField(title: "Название объявления ", serverName: "title"), .video(title: "Видео", serverName: "video"), .textField(title: "Адрес", serverName: "address"), .textField(title: "Цена", serverName: "price"),.textField(title: "Площадь, м2", serverName: "square")]
        case "Квартира":
            cellTypes = [.textField(title: "Название объявления", serverName: "title"), .video(title: "Видео", serverName: "video"), .textView(title: "Адрес", serverName: "address"), .textField(title: "Цена", serverName: "price"), .textField(title: "Кол-во комнат", serverName: "rooms"), .textField(title: "Площадь, м2", serverName: "square"), .textField(title: "Материал стен", serverName: "material")]
        case "Дома":
            cellTypes = [.textField(title: "Название объявления", serverName: "title"), .video(title: "Видео", serverName: "video"), .textView(title: "Адрес", serverName: "address"), .textField(title: "Цена", serverName: "price"), .textField(title: "Этажей в доме", serverName: "floors"), .textField(title: "Год постройки", serverName: "year"), .textField(title: "Площадь, м2", serverName: "square"), .textField(title: "Материал стен", serverName: "material")]
        case "Работа":
            if switcherValue == 0 {
                cellTypes = [.textField(title: "Название вакансии", serverName: "title"), .video(title: "Видео", serverName: "video"), .textField(title: "График", serverName: "schedule"), .textField(title:"Опыт работы", serverName: "expierenceYears"), .textField(title:"Зарплата", serverName: "price"), .textView(title:"Описание", serverName: "description")]
            } else {
                cellTypes = [.textField(title: "Название резюме", serverName: "title"), .video(title: "Видео", serverName: "video"), .textField(title: "Желаемый график", serverName: "schedule"), .textField(title: "Опыт", serverName: "expierenceYears"), .textField(title: "Ожидаемая зарплата", serverName: "price"), .textView(title: "Описание", serverName: "description")]
            }
        default:
            break
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
        let teddyService = TeddyAPIService()
        teddyService.addProduct(json: json) { result in
            switch result {
            case .success(let id):
                print(id)
                self.dismiss(animated: true)
            case .failure(let error):
                let alertBuilder = AddAdAlertBuilder(errorType: error)
                alertBuilder.configureAlert { alert in
                    self.present(alert, animated: true)
                }
            }
        }
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
    
    @objc func didTapAround() {
        view.endEditing(true)
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
        guard let indexOfCell = cellTypes.lastIndex(of: .textField(title: "Материал стен", serverName: "material")),
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
