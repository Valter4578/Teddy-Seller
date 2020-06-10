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
     
        configureCells()
        
        setupAddButton()
        setupTableView() 
        setupNavigationBar()
    }
    
    // MARK:- Private functions
    private func configureCells() {
        cellTypes.forEach {
            switch $0 {
            case .video(let title):
                let videoCell = CreateProductVideoTableViewCell(style: .default, reuseIdentifier: videoCellId)
                videoCell.label.text = title
                tableView.register(CreateProductVideoTableViewCell.self, forCellReuseIdentifier: videoCellId)
                cells.append(videoCell)
                tableView.rowHeight = 300
                tableView.reloadData()
                
            case .textField(let title):
                let textFieldCell = CreateProductTextFieldTableViewCell(style: .default, reuseIdentifier: textFieldCellId)
                textFieldCell.label.text = title
                tableView.register(CreateProductTextFieldTableViewCell.self, forCellReuseIdentifier: textFieldCellId)
                print(title)
                cells.append(textFieldCell)
                tableView.rowHeight = 125
                tableView.reloadData()
            case .textView(let title):
                let textViewCell = CreateProductTextViewTableViewCell(style: .default, reuseIdentifier: textViewCellId)
                textViewCell.label.text = title
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
            cellTypes = [.video("Видео"), .textField("Марка"), .textField("Модель"), .textField("Цена"), .textField("Год выпуска"), .textField("Пробег"), .textView("Описание")]
        case "Электроника":
            cellTypes = [.textField("Название товара"), .video("Видео"), .textField("Марка"), .textField("Модель"), .textField("Цена"), .textField("Год выпуска"), .textView("Описание")]
        case "Комната":
            cellTypes = [.textField("Название объявления"), .video("Видео"), .textView("Адрес"), .textField("Цена"), .textField("Площадь, м2")]
        case "Участки":
            cellTypes = [.textField("Название объявления "), .video("Видео"), .textField("Адрес"), .textField("Цена"),.textField("Площадь, м2")]
        case "Квартира":
            cellTypes = [.textField("Название объявления"), .video("Видео"), .textView("Адрес"), .textField("Цена"), .textField("Кол-во комнат"), .textField("Площадь, м2"), .textField("Материал стен")]
        case "Дома":
            cellTypes = [.textField("Название объявления"), .video("Видео"), .textView("Адрес"), .textField("Цена"), .textField("Этажей в доме"), .textField("Год постройки"), .textField("Площадь, м2"), .textField("Материал стен")]
        case "Работа":
            if switcherValue == 0 {
                cellTypes = [.textField("Название вакансии"), .video("Видео"), .textField("График"), .textField("Опыт работы"), .textField("Зарплата"), .textView("Описание")]
            } else {
                cellTypes = [.textField("Название резюме"), .video("Видео"), .textField("Желаемый график"), .textField("Опыт"), .textField("Ожидаемая зарплата"), .textView("Описание")]
            }
        default:
            break
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
