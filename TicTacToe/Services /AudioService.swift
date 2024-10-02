//
//  AudioService.swift
//  TicTacToe
//
//  Created by NikitaKorniuk   on 02.10.24.
//

import AVFoundation
import SwiftUI

final class AudioService: ObservableObject {
    @Published var isPlaySound = true {
        didSet{
            isPlaySound ? playSound(soundFileName: <#T##String#>) : stop()
        }
    }
    private var audioPlayer: AVAudioPlayer?
    
    private func playSound(soundFileName: String) {
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let audioPlayer = audioPlayer else { return }
            audioPlayer.play()
        } catch let error {
            print(error.localizedDescription)
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
