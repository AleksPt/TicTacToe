//
//  AudioService.swift
//  TicTacToe
//
//  Created by NikitaKorniuk   on 02.10.24.
//

import AVFoundation
import SwiftUI

final class AudioService: ObservableObject {
    @Published var isPlaySound: Bool = false
    private var audioPlayer: AVAudioPlayer?
    private var selectedMusic: Constants.Music = .classical

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleMusicSettingsChanged(notification:)), name: .musicSettingsChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func handleMusicSettingsChanged(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        if let isOnMusic = userInfo["isOnMusic"] as? Bool {
            self.isPlaySound = isOnMusic
            isOnMusic ? playSound(soundFileName: selectedMusic.rawValue) : stop()
        }
        
        if let classicMusic = userInfo["classicMusic"] as? Bool, classicMusic {
            selectedMusic = .classical
            if isPlaySound { playSound(soundFileName: selectedMusic.rawValue) }
        }
        
        if let instrumentalMusic = userInfo["instrumentalMusic"] as? Bool, instrumentalMusic {
            selectedMusic = .instrumentals
            if isPlaySound { playSound(soundFileName: selectedMusic.rawValue) }
        }
        
        if let natureMusic = userInfo["natureMusic"] as? Bool, natureMusic {
            selectedMusic = .nature
            if isPlaySound { playSound(soundFileName: selectedMusic.rawValue) }
        }
    }
    
    private func playSound(soundFileName: String) {
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
    }

    func stop() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
    }
}

extension NSNotification.Name {
    static let musicSettingsChanged = NSNotification.Name("musicSettingsChanged")
}
