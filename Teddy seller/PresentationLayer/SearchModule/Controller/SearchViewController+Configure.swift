//
//  SearchViewController+Configure.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 20.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension SearchViewController {
    func configureCells() {
           cellTypes.forEach {
               switch $0 {
               case .textField(let title, let serverName, let needsOnlyNumbers):
                   let textFieldCell = TextFieldTableViewCell(style: .default, reuseIdentifier: textFieldCellId)
                   textFieldCell.label.text = title
                   textFieldCell.serverName = serverName
                   
                   if needsOnlyNumbers {
                       textFieldCell.textField.keyboardType = .numberPad
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
               default:
                    break 
               }
           }
       }
}
