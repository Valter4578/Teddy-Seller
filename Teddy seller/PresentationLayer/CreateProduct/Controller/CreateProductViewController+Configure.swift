//
//  CreateProductViewController+Configure.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 14.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension CreateProductViewController {
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
                
            case .textField(let title, let serverName):
                let textFieldCell = CreateProductTextFieldTableViewCell(style: .default, reuseIdentifier: textFieldCellId)
                textFieldCell.label.text = title
                textFieldCell.serverName = serverName
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
}
