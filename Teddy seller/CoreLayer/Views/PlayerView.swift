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

protocol PlayerViewDelegate: class {
    func didTapOnButton(indexOfPlayer: Int)
}

final class PlayerView: UIView {
    // MARK:- Views
    lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(playImage, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK:- Private properties
    private let playImage: UIImage = #imageLiteral(resourceName: "play").withRenderingMode(.alwaysTemplate)
    private let pauseImage: UIImage = #imageLiteral(resourceName: "pause").withRenderingMode(.alwaysTemplate)
    
    // MARK:- Properties
    var index: Int? 
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    var isPlaying: Bool = false { // when button is pause
        didSet {
            isPlaying ? pausePlayer() : playPlayer()
        }
    }
    
    var isButtonHidden: Bool = false  // false when alpha = 0
    
    weak var delegate: PlayerViewDelegate?
    
    // MARK:- Functions
    func setPlayerURL(url: URL) {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        player.replaceCurrentItem(with: playerItem)
        player.automaticallyWaitsToMinimizeStalling = true 
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.bounds
        
        setupPlayPauseButton()
        
        makeLooping()
        
        player.isMuted = true
    }
    
    // MARK:- Private functions
    private func hideButton() {
        self.isButtonHidden = true
        UIView.animate(withDuration: 0.2) {
            self.playPauseButton.alpha = 0
        }
    }
    
    private func showButton() {
        self.isButtonHidden = false
        UIView.animate(withDuration: 0.2) {
            self.playPauseButton.alpha = 1
        }
    }
    
    func pausePlayer() {
        playPauseButton.alpha = 1
        playPauseButton.setImage(playImage, for: .normal)
        player.pause()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.hideButton()
        }
    }
    
    func playPlayer() {
        playPauseButton.alpha = 1
        playPauseButton.setImage(pauseImage, for: .normal)
        player.play()
    }
    
    private func makeLooping() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
    }
    
    // MARK:- Selectors
    @objc func didSelectButton() {
        isPlaying.toggle()

        if let selectedIndex = index {
            delegate?.didTapOnButton(indexOfPlayer: selectedIndex)
        }
    }
    
    @objc func didTapOnVideo() {
        isButtonHidden ? showButton() : hideButton()
    }
    
    // MARK:- Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGestureRecognizer()
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
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnVideo))
        addGestureRecognizer(tapGestureRecognizer)
    }
}
