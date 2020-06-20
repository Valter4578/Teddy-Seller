//
//  SearchViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 20.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK:- Properties
    var category: Category? {
        didSet {
            configureCellTypes()
        }
    }
    
    let sliderCellId = "SearchViewControllerSliderCell"
    let textViewCellId = "SearchViewControllerTextViewCell"
    let textFieldCellId = "SearchViewControllerTextFieldCell"
    
    private let materials = ["деревянный", "кирпичный", "блочный", "панельный"]
    
    var cellTypes: [CellType] = []
    
    var cells: [UITableViewCell] = []
    
    // MARK:- Views
    let findButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainBlue
        button.setTitle("Найти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let tableView = UITableView()
    
    var materialsPickerView: UIPickerView?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem?.title = ""
        
        setupFindButton()
        configureCells()
        setupTableView()
    }
    
    // MARK:- Functions
    
    
    // MARK:- Private functions
    
    // MARK:- Selectors
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print(rangeSlider.lowerValue)
        print(rangeSlider.upperValue)
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    }
    
    @objc func didTapBack() {
        dismiss(animated: true)
    }
}

// MARK:- UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          switch cellTypes[indexPath.row] {
          case .textField(_): return 105
          case .video(_): return 235
          case .textView(_): return 235
          case .slider(_): return 67
          }
      }
}

// MARK:- UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }
}

// MARK:- UIPickerViewDelegate
extension SearchViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let indexOfCell = cellTypes.lastIndex(of: .textField(title: "Материал стен", serverName: "material", needsOnlyNumbers: false)),
            let materialCell = cells[indexOfCell] as? TextFieldTableViewCell else { return }
        materialCell.textField.text = materials[row]
    }
}

// MARK:- UIPickerViewDataSource
extension SearchViewController: UIPickerViewDataSource {
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
