//
//  CreateProductViewController.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 08.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices
import IQKeyboardManagerSwift

protocol CreateProductDelegate: class {
    func didAddNewProduct()
}

enum VideoSelectedFrom {
    case camera
    case gallery
}

class CreateProductViewController: UIViewController {
    // MARK:- Private properties
    let videoCellId = "CreateProductViewControllerVideoCell"
    let textFieldCellId = "CreateProductViewControllerTextFieldCell"
    let textViewCellId = "CreateProductViewControllerTextViewCell"
    let sliderCellId = "CreateProductViewControllerSliderCell"
    
    private let materials = ["деревянный", "кирпичный", "блочный", "панельный"]
    
    // MARK:- Properties
    weak var delegate: CreateProductDelegate!
    
    var switcherValue: Int?
    
    var cellTypes: [CellType] = []
    let defaultCellTypes: [CellType] = [.textField(title: "Название товара", serverName: "title", needsOnlyNumbers: false), .video(title: "Видео", serverName: "video"), .textField(title: "Цена", serverName: "price", needsOnlyNumbers: true), .textField(title: "Город", serverName: "city", needsOnlyNumbers: false)]
    
    var category: Category? {
        didSet {
            configureCellTypes()
        }
    }
    
    var cells: [UITableViewCell] = []
    
    var productId: String = ""
    
    // video
    var videoSelectedFrom: VideoSelectedFrom?
    var isVideoSelected: Bool = false
    var videoUrl: URL?
    
    // top bar in category feed
    var switcherServerName: String?
    var selectedIndex: Int?
    
    
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
    
    let playerView = PlayerView()
    
    let loaderView = LoaderView()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCells()
        
        setupAddButton()
        setupTableView()
        setupNavigationBar()
        setupPickerView()
        
        
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.enable = true
    }
    
    // MARK:- Private functions
    private func hideKeyboardByTapAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAround))
        view.addGestureRecognizer(tap)
    }
    
    private func addProduct(json: String, completionHandler: @escaping () -> ()) {
        let teddyService = TeddyAPIService()
        teddyService.addProduct(json: json) { result in
            switch result {
            case .success(let id):
                print(id)
                self.productId = id
                completionHandler()
            case .failure(let error):
                let alertBuilder = AddAdAlertBuilder(errorType: error)
                alertBuilder.configureAlert { alert in
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    private func uploadVideo() {
        guard let token = UserDefaults.standard.string(forKey: "token"),
            let url = videoUrl else { return }
        
        let teddyService = TeddyAPIService()
        
        teddyService.uploadVideo(token: token, id: productId, videoUrl: url) { result in
            self.loaderView.acitivityIndicator.stopAnimating()
            switch result {
            case .success(let status):
                print(status)
                self.delegate.didAddNewProduct()
                self.dismiss(animated: true)
            case .failure(let error):
                print(error)
                let alertController = UIAlertController(title: "Ошибка", message: "Что-то пошло не так. Попробуйте еще раз", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(action)
                
                if error == .unrecognizedError {
                    alertController.message = "Видимо у вас что-то с интернетом. Попробуйте позже"
                }
                self.present(alertController, animated: true)
            }
        }
    }
    
    private func presentLoader() {
        view.addSubview(loaderView)
        
        loaderView.layer.cornerRadius = 10
        
        loaderView.snp.makeConstraints { maker in
            maker.center.equalTo(view)
            maker.height.equalTo(60)
            maker.width.equalTo(60)
        }
        
        loaderView.acitivityIndicator.startAnimating()
    }
    
    
    // MARK:- Selectors
    @objc func dismissCreateProduct() {
        dismiss(animated: true)
    }
    
    @objc func didTapAddButton() {
        
        if !isVideoSelected {
            let alertController = UIAlertController(title: "Видео не выбрано", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
                
        var jsonParametrs: [String: Any] = [:]
        for i in 0...cells.count - 1 {
            if let textViewCell = cells[i] as? TextViewTableViewCell {
                guard let serverName = textViewCell.serverName else { return }
                jsonParametrs.updateValue(textViewCell.textView.text, forKey: serverName)
            }
            
            if let textFieldCell = cells[i] as? TextFieldTableViewCell {
                guard let serverName = textFieldCell.serverName else { continue }
                if serverName == "title" && category?.title != "Автомобили" || serverName == "price" || serverName == "city" {
                    guard !(textFieldCell.textField.text?.isEmpty ?? true) else {
                        AlertBuilder.createAlert(message: "Обязательные поля не заполнены", for: self)
                        return
                    }
                }
                
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
        
        if let serverName = switcherServerName, serverName != "", let index = switcherValue {
            let stringIndex = String(index)
            jsonParametrs.updateValue(stringIndex, forKey: serverName)
        }
        
        presentLoader()
        
        let json = JSONBuilder.createJSON(parametrs: jsonParametrs)
        addProduct(json: json) {
            self.uploadVideo()
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
    
    /// Hide keyboard by tap everywhere on screen
    @objc func didTapAround() {
        view.endEditing(true)
    }
    
    @objc func didTapOnVideoContainer() {
        let alertController = UIAlertController(title: nil, message: "Выберите опцию", preferredStyle: .actionSheet)
        
        let galleryAction = UIAlertAction(title: "Галерея", style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.videoSelectedFrom = .gallery
            strongSelf.isVideoSelected = true
            VideoService.startVideoBrowsing(delegate: strongSelf, sourceType: .savedPhotosAlbum)
        }
        
        let cameraAction = UIAlertAction(title: "Снять видео", style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.videoSelectedFrom = .camera
            strongSelf.isVideoSelected = true
            VideoService.startVideoBrowsing(delegate: strongSelf, sourceType: .camera)
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
    
        alertController.addAction(galleryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
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
    
    @objc func didCaptureVideo(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
        let title = (error == nil) ? "Успешно" : "Ошибка"
        let message = (error == nil) ? "Видео сохранено" : "Не удалось сохранить видео"
                
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print(rangeSlider.lowerValue)
        print(rangeSlider.upperValue)
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    }
}


// MARK:- UITableViewDelegate
extension CreateProductViewController: UITableViewDelegate {
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
            let materialCell = cells[indexOfCell] as? TextFieldTableViewCell else { return }
        materialCell.textField.text = materials[row]
    }
}

// MARK:- UIPickerViewDataSource
extension CreateProductViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // set "деревянный" as default value of text field
        if let indexOfCell = cellTypes.lastIndex(of: .textField(title: "Материал стен", serverName: "material", needsOnlyNumbers: false)), let materialCell = cells[indexOfCell] as? TextFieldTableViewCell {
            materialCell.textField.text = materials[0]
        }
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
            guard let addressCell = cells[index] as? TextViewTableViewCell else { return }
            addressCell.textView.text = address
        }
    }
}

// MARK:- FindCityViewControllerDelegate
extension CreateProductViewController: FindCityViewControllerDelegate {
    func setSelectedCity(cityName: String) {
        if let indexOfCityCell = cellTypes.firstIndex(of: .textField(title: "Город", serverName: "city", needsOnlyNumbers: false)) {
            guard let cityCell = cells[indexOfCityCell] as? TextFieldTableViewCell else { return }
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

// MARK:- UIImagePickerControllerDelegate
extension CreateProductViewController: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL else { return }
        
        switch videoSelectedFrom {
        case .camera:
            guard UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) else { return }
            UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(didCaptureVideo(_:didFinishSavingWithError:contextInfo:)), nil)
            
            dismiss(animated: true) {
                self.videoUrl = url
                self.playerView.setPlayerURL(url: url)
                self.playerView.alpha = 1
                self.playerView.layer.cornerRadius = 24
                self.playerView.playerLayer.cornerRadius = 24
                self.playerView.player.play()
            }
        case .gallery:
            dismiss(animated: true) {
                self.videoUrl = url
                self.playerView.setPlayerURL(url: url)
                self.playerView.alpha = 1
                self.playerView.layer.cornerRadius = 24
                self.playerView.playerLayer.cornerRadius = 24
                self.playerView.player.play()
            }
        case .none:
            dismiss(animated: true) {
                let alertController = UIAlertController(title: "Ошибка", message: "Не удалось выбрать видео", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- UINavigationControllerDelegate 
extension CreateProductViewController: UINavigationControllerDelegate {
}

