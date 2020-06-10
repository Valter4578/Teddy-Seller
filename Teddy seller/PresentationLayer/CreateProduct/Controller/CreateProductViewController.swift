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
        let view = ArrowView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.transform = CGAffineTransform(rotationAngle: -(.pi/2))
        return view
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainBlue
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.placeholderBlack, for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        return button
    }()
    
    var tableView: UITableView = UITableView()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureCells()
        
        setupAddButton()
        setupTableView() 
        setupNavigationBar()
    }
    
    // MARK:- Private functions
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
            cellTypes = [.textField(title: "Название объявления", serverName: "title"), .video(title: "Видео", serverName: "video"), .textView(title: "Адрес", serverName: "address"), .textField(title: "Цена", serverName: "price"), .textField(title: "Этажей в доме", serverName: "floors"), .textField(title: "Год постройки", serverName: "year"), .textField(title: "Площадь, м2", serverName: "square"), .textField(title: "Материал стен", serverName: "material   ")]
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
        for i in 0...cells.count - 1 {
            if let videoCell = cells[i] as? CreateProductVideoTableViewCell {
                print("\(videoCell.serverName) -- \(videoCell.label.text)")
            }
            
            if let textViewCell = cells[i] as? CreateProductTextViewTableViewCell {
                print("\(textViewCell.serverName) -- \(textViewCell.label.text)")
            }
            
            if let textFieldCell = cells[i] as? CreateProductTextFieldTableViewCell {
                print("\(textFieldCell.serverName) -- \(textFieldCell.label.text)")
            }
        }
//        dismiss(animated: true)
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
