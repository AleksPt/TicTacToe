//
//  AudioService.swift
//  TicTacToe
//
//  Created by NikitaKorniuk   on 02.10.24.
//

import AVFoundation
import SwiftUI

final class AudioService: ObservableObject {
    @Published var isPlaySound: Bool {
        didSet{
            isPlaySound = settingsViewModel.isOnMusic
            isPlaySound ? playSound(soundFileName: selectedMucis.rawValue) : stop()
        }
    }
    @EnvironmentObject private var settingsViewModel: SettingsViewModel {
        didSet{
            isPlaySound = settingsViewModel.isOnMusic
            selectedMusic()
        }
    }
    
    private var audioPlayer: AVAudioPlayer?
    private var selectedMucis: Constants.Music = .classical {
        didSet{
            isPlaySound ? playSound(soundFileName: selectedMucis.rawValue) : stop()
        }
    }
    init(isPlaySound: Bool = true) {
        self.isPlaySound = isPlaySound
        isPlaySound ? playSound(soundFileName: selectedMucis.rawValue) : stop()
    }
    
    private func playSound(soundFileName: String) {
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let audioPlayer = audioPlayer else { return }
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func selectedMusic(){
        if settingsViewModel.classicMusic{
            selectedMucis = .classical
        } else if settingsViewModel.instrumentalMusic {
            selectedMucis = .instrumentals
        } else if settingsViewModel.natureMusic {
            selectedMucis = .nature
        }
    }
    
    func pause() {
        audioPlayer?.pause()
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
    }
}
