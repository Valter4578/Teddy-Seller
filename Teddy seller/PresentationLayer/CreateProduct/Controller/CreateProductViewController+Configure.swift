//
//  CreateProductViewController+Configure.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 14.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension CreateProductViewController {
    // MARK:- Functions
    func configureCells() {
        cellTypes.forEach {
            switch $0 {
            case .video(let title, let serverName):
                let videoCell = CreateProductVideoTableViewCell(style: .default, reuseIdentifier: videoCellId)
                videoCell.label.text = title
                videoCell.serverName = serverName
                
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnVideoContainer))
                videoCell.videoContainer.addGestureRecognizer(gestureRecognizer)
                
                tableView.register(CreateProductVideoTableViewCell.self, forCellReuseIdentifier: videoCellId)
                cells.append(videoCell)
                tableView.rowHeight = 300
                tableView.reloadData()
                
            case .textField(let title, let serverName, let needsOnlyNumbers):
                let textFieldCell = CreateProductTextFieldTableViewCell(style: .default, reuseIdentifier: textFieldCellId)
                textFieldCell.label.text = title
                textFieldCell.serverName = serverName
                
                if needsOnlyNumbers {
                    textFieldCell.textField.keyboardType = .numberPad
                }
                
                if title == "Город" {
                    guard let cityName = UserDefaults.standard.string(forKey: "city") else { return }
                    textFieldCell.textField.text = cityName
                    textFieldCell.textField.isUserInteractionEnabled = false
                    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentFindCity))
                    gestureRecognizer.numberOfTapsRequired = 1
                    textFieldCell.contentView.addGestureRecognizer(gestureRecognizer)
                }
                
                tableView.register(CreateProductTextFieldTableViewCell.self, forCellReuseIdentifier: textFieldCellId)
                cells.append(textFieldCell)
                tableView.rowHeight = 125
                tableView.reloadData()
            case .textView(let title, let serverName):
                let textViewCell = CreateProductTextViewTableViewCell(style: .default, reuseIdentifier: textViewCellId)
                textViewCell.label.text = title
                textViewCell.serverName = serverName
                tableView.register(CreateProductTextViewTableViewCell.self, forCellReuseIdentifier: textViewCellId)
                
                if title == "Адрес" {
                    textViewCell.textView.isEditable = false
                    
                    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapAddressTextView))
                    textViewCell.textView.addGestureRecognizer(gestureRecognizer)
                }
                
                cells.append(textViewCell)
                tableView.rowHeight = 260
                
                tableView.reloadData()
            }
        }
    }
    
    func configureCellTypes() {
        switch category?.title {
            // Автомобили
        case "Легковые", "Спецтехника", "Грузовые", "Мотоциклы":
            cellTypes = [.video(title: "Видео", serverName: "video"), .textField(title: "Марка", serverName: "mark", needsOnlyNumbers: false), .textField(title: "Модель", serverName: "model", needsOnlyNumbers: false), .textField(title: "Цена", serverName: "price", needsOnlyNumbers: true), .textField(title: "Год выпуска", serverName: "year", needsOnlyNumbers: true), .textField(title: "Пробег", serverName: "mileage", needsOnlyNumbers: true), .textView(title: "Описание", serverName: "description"), .textField(title: "Город", serverName: "city", needsOnlyNumbers: false)]
            // Электроника
        case "Электроника":
            cellTypes = [.textField(title: "Название товара", serverName: "title", needsOnlyNumbers: false), .video(title: "Видео", serverName: "video"), .textField(title: "Марка", serverName: "mark", needsOnlyNumbers: false), .textField(title: "Модель", serverName: "model", needsOnlyNumbers: false), .textField(title: "Цена", serverName: "price", needsOnlyNumbers: true), .textField(title: "Год выпуска", serverName: "year", needsOnlyNumbers: true), .textView(title: "Описание", serverName: "description"), .textField(title: "Город", serverName: "city", needsOnlyNumbers: false)]
            // Недвижимость
        case "Комната":
            cellTypes = [.textField(title: "Название объявления", serverName: "title", needsOnlyNumbers: false), .video(title: "Видео", serverName: "video"), .textView(title: "Адрес", serverName: "address"), .textField(title: "Цена", serverName: "price", needsOnlyNumbers: true), .textField(title: "Площадь, м2", serverName: "square", needsOnlyNumbers: true)]
        case "Участки":
            cellTypes = [.textField(title: "Название объявления ", serverName: "title", needsOnlyNumbers: false), .video(title: "Видео", serverName: "video"),
                         .textView(title: "Адрес", serverName: "address"), .textField(title: "Цена", serverName: "price", needsOnlyNumbers: true),.textField(title: "Площадь, м2", serverName: "square", needsOnlyNumbers: true)]
        case "Квартира":
            cellTypes = [.textField(title: "Название объявления", serverName: "title", needsOnlyNumbers: false), .video(title: "Видео", serverName: "video"), .textView(title: "Адрес", serverName: "address"), .textField(title: "Цена", serverName: "price", needsOnlyNumbers: true), .textField(title: "Кол-во комнат", serverName: "rooms", needsOnlyNumbers: false), .textField(title: "Площадь, м2", serverName: "square", needsOnlyNumbers: true), .textField(title: "Материал стен", serverName: "material", needsOnlyNumbers: false)]
        case "Дома":
            cellTypes = [.textField(title: "Название объявления", serverName: "title", needsOnlyNumbers: false), .video(title: "Видео", serverName: "video"), .textView(title: "Адрес", serverName: "address"), .textField(title: "Цена", serverName: "price", needsOnlyNumbers: true), .textField(title: "Этажей в доме", serverName: "floors", needsOnlyNumbers: true), .textField(title: "Год постройки", serverName: "year", needsOnlyNumbers: true), .textField(title: "Площадь, м2", serverName: "square", needsOnlyNumbers: true), .textField(title: "Материал стен", serverName: "material", needsOnlyNumbers: false)]
            // Работа
        case "Работа":
            if switcherValue == 0 {
                cellTypes = [.textField(title: "Название вакансии", serverName: "title", needsOnlyNumbers: false), .video(title: "Видео", serverName: "video"), .textField(title: "График", serverName: "schedule", needsOnlyNumbers: true), .textField(title:"Опыт работы", serverName: "expierenceYears", needsOnlyNumbers: true), .textField(title:"Зарплата", serverName: "price", needsOnlyNumbers: true), .textView(title:"Описание", serverName: "description"), .textField(title: "Город", serverName: "city", needsOnlyNumbers: false)]
            } else {
                cellTypes = [.textField(title: "Название резюме", serverName: "title", needsOnlyNumbers: false), .video(title: "Видео", serverName: "video"), .textField(title: "Желаемый график", serverName: "schedule", needsOnlyNumbers: true), .textField(title: "Опыт", serverName: "expierenceYears", needsOnlyNumbers: true), .textField(title: "Ожидаемая зарплата", serverName: "price", needsOnlyNumbers: true), .textView(title: "Описание", serverName: "description"), .textField(title: "Город", serverName: "city", needsOnlyNumbers: false)]
            }
        default:
            cellTypes = defaultCellTypes
        }
    }
}
