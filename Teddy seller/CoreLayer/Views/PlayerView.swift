//
//  PlayerView.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 11.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import AVFoundation
import UIKit

class PlayerView: UIView {
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    func setPlayerURL(url: URL) {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        player.automaticallyWaitsToMinimizeStalling = true 
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.bounds
    }
}
