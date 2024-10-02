//
//  TimerViewModel.swift
//  TicTacToe
//
//  Created by Алексей on 02.10.2024.
//

import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    var timeValue: Int? {
        didSet {
            time = timeValue
        }
    }
    @Published var time: Int?
    var timer: AnyCancellable?
    
    func startTimer() {
        guard time != nil else { return }
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.time == 0 {
                    self.pauseTimer()
                } else {
                    withAnimation {
                        self.time! -= 1
                    }
                }
            }
    }
    
    func pauseTimer() {
        self.timer?.cancel()
        self.timer = nil
    }
    
    func stopTimer() {
        pauseTimer()
        time = timeValue
    }
}
