//
//  TimerViewModel.swift
//  TicTacToe
//
//  Created by Алексей on 02.10.2024.
//

import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    @Published var time: Int?
    var timer: AnyCancellable?
    
    init() {
        time = settingsViewModel.timer?.rawValue
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                withAnimation {
                    guard self.time != nil else { return }
                    self.time! -= 1
                }
            }
    }
    
    func pauseTimer() {
        self.timer?.cancel()
        self.timer = nil
    }
    
    func stopTimer() {
        pauseTimer()
        time = 0
    }
}
