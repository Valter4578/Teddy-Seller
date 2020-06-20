//
//  CreateProductViewController+Configure.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 14.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

extension CreateProductViewController {
    // MARK:- Functions
    func configureCells() {
        cellTypes.forEach {
            switch $0 {
            case .video(let title, let serverName):
                let videoCell = VideoTableViewCell(style: .default, reuseIdentifier: videoCellId)
                videoCell.label.text = title
                videoCell.serverName = serverName
                
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnVideoContainer))
                videoCell.videoContainer.addGestureRecognizer(gestureRecognizer)
                
                playerView.alpha = 1
                videoCell.videoContainer.addSubview(playerView)
                
                playerView.snp.makeConstraints { maker in
                    maker.size.equalTo(videoCell.videoContainer)
                    maker.center.equalTo(videoCell.videoContainer)
                }
                playerView.clipsToBounds = true 
                
                tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: videoCellId)
                cells.append(videoCell)
                tableView.rowHeight = 300
                tableView.reloadData()
                
            case .textField(let title, let serverName, let needsOnlyNumbers):
                let textFieldCell = TextFieldTableViewCell(style: .default, reuseIdentifier: textFieldCellId)
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
                
                tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: textFieldCellId)
                cells.append(textFieldCell)
                tableView.rowHeight = 125
                tableView.reloadData()
            case .textView(let title, let serverName):
                let textViewCell = TextViewTableViewCell(style: .default, reuseIdentifier: textViewCellId)
                textViewCell.label.text = title
                textViewCell.serverName = serverName
                tableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: textViewCellId)
                
                if title == "Адрес" {
                    textViewCell.textView.isEditable = false
                    
                    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapAddressTextView))
                    textViewCell.textView.addGestureRecognizer(gestureRecognizer)
                }
                
                cells.append(textViewCell)
                tableView.rowHeight = 260
                
                tableView.reloadData()
            case .slider(let title, let serverName):
                let sliderCell = SliderTableViewCell(style: .default, reuseIdentifier: sliderCellId)
                sliderCell.label.text = title
                sliderCell.serverName = serverName
                
                sliderCell.slider.addTarget(self, action: #selector(rangeSliderValueChanged(_:)), for: .valueChanged)
                
                tableView.register(SliderTableViewCell.self, forCellReuseIdentifier: sliderCellId)
                
                cells.append(sliderCell)
                tableView.rowHeight = 60
                
                tableView.reloadData()
            }
        }
    }
    
    func configureCellTypes() {
        switch category?.title {
            // Автомобили
        case "Легковые", "Спецтехника", "Грузовые", "Мотоциклы":
            cellTypes = [.video(title: "Видео", serverName: "video"), .textField(title: "Марка", serverName: "mark", needsOnlyNumbers: false), .textField(title: "Модель", serverName: "model", needsOnlyNumbers: false), .textField(title: "Цена", serverName: "price", needsOnlyNumbers: true), .textField(title: "Год выпуска", serverName: "year", needsOnlyNumbers: true), .textField(title: "Пробег", serverName: "mileage", needsOnlyNumbers: true), .textView(title: "Описание", serverName: "description"), .textField(title: "Город", serverName: "city", needsOnlyNumbers: false), .slider(title: "test", serverName: "test")]
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
