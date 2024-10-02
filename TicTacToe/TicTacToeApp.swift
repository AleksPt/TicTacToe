//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Алексей on 29.09.2024.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    @StateObject private var settingsViewModel = SettingsViewModel()
    @StateObject private var timerViewModel = TimerViewModel()
    @StateObject private var audioService = AudioService()
    
    var body: some Scene {
        WindowGroup {
            OnbordingView()
                .environmentObject(settingsViewModel)
                .environmentObject(timerViewModel)
                .environmentObject(audioService)
        }
    }
}
