//
//  AudioService.swift
//  TicTacToe
//
//  Created by NikitaKorniuk   on 02.10.24.
//

import AVFoundation
import SwiftUI

final class AudioService: ObservableObject {
    @Published var isPlaySound: Bool = UserDefaults.standard.bool(forKey: Constants.KeysUD.isOnMusic)
    private var audioPlayer: AVAudioPlayer?
    @Published var selectedMusic: Constants.Music? = .classical
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleMusicSettingsChanged(notification:)), name: .musicSettingsChanged, object: nil)
//        loadInitialSettings()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func loadInitialSettings() {
        let isOnMusic = UserDefaults.standard.bool(forKey: Constants.KeysUD.isOnMusic)
        let classicMusic = UserDefaults.standard.bool(forKey: Constants.KeysUD.classicMusic)
        let instrumentalMusic = UserDefaults.standard.bool(forKey: Constants.KeysUD.instrumentalMusic)
        let natureMusic = UserDefaults.standard.bool(forKey: Constants.KeysUD.natureMusic)

        self.isPlaySound = isOnMusic
        
        if classicMusic {
            selectedMusic = .classical
        } else if instrumentalMusic {
            selectedMusic = .instrumentals
        } else if natureMusic {
            selectedMusic = .nature
        }

        if isPlaySound, let music = selectedMusic {
            playSound(soundFileName: music.rawValue)
        }
    }
    
    @objc private func handleMusicSettingsChanged(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        if let isOnMusic = userInfo["isOnMusic"] as? Bool {
            self.isPlaySound = isOnMusic
            if isOnMusic, let music = selectedMusic {
                playSound(soundFileName: music.rawValue)
            } else {
                stop()
            }
        }
        
        if let classicMusic = userInfo["classicMusic"] as? Bool, classicMusic {
            selectedMusic = .classical
            if isPlaySound { playSound(soundFileName: selectedMusic!.rawValue) }
        }
        
        if let instrumentalMusic = userInfo["instrumentalMusic"] as? Bool, instrumentalMusic {
            selectedMusic = .instrumentals
            if isPlaySound { playSound(soundFileName: selectedMusic!.rawValue) }
        }
        
        if let natureMusic = userInfo["natureMusic"] as? Bool, natureMusic {
            selectedMusic = .nature
            if isPlaySound { playSound(soundFileName: selectedMusic!.rawValue) }
        }
    }
    
    func playSound(soundFileName: String) {
        guard isPlaySound else { return }
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
