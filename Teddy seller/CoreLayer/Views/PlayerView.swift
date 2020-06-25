//
//  PlayerView.swift
//  Teddy seller
//
//  Created by Максим Алексеев on 11.06.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import AVFoundation
import UIKit
import SnapKit

final class PlayerView: UIView {
    // MARK:- Views
    lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(playImage, for: .normal)
        return button
    }()
    
    // MARK:- Private properties
    private let playImage: UIImage = #imageLiteral(resourceName: "play")
    private let pauseImage: UIImage = #imageLiteral(resourceName: "pause")
    
    // MARK:- Properties
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    var isPlaying: Bool = false { // when button is pause
        didSet {
            isPlaying ? pausePlayer() : playPlayer()
        }
    }
    
    // MARK:- Functions
    func setPlayerURL(url: URL) {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        player.automaticallyWaitsToMinimizeStalling = true 
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.bounds
        
        setupPlayPauseButton()
    }
    
    // MARK:- Private functions
    private func pausePlayer() {
        playPauseButton.alpha = 1
        playPauseButton.setImage(pauseImage, for: .normal)
        player.pause()
    }
    
    private func playPlayer() {
        playPauseButton.alpha = 1
        playPauseButton.setImage(playImage, for: .normal)
        player.play()
    }
    
    // MARK:- Selectors
    @objc func didSelectButton() {
        isPlaying.toggle()
    }
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setups
    private func setupPlayPauseButton() {
        addSubview(playPauseButton)
                
        playPauseButton.snp.makeConstraints { maker in
            maker.center.equalTo(self)
            maker.size.equalTo(50)
        }
        
        playPauseButton.addTarget(self, action: #selector(didSelectButton), for: .touchUpInside)
    }
}
