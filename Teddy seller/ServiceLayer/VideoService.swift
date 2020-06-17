//
//  VideoService.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 16.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class VideoService {
    
    static func startVideoBrowsing(delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate, sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = sourceType
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        delegate.present(mediaUI, animated: true, completion: nil)
        print(mediaUI.delegate)
    }
}
