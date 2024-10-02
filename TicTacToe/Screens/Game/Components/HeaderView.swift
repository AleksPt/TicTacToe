//
//  HeaderView.swift
//  TicTacToe
//
//  Created by Алексей on 30.09.2024.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var viewModel: GameViewModel
    @StateObject private var settingsViewModel = SettingsViewModel()
    @StateObject private var timerViewModel = TimerViewModel()
    
    var body: some View {
        HStack {
            ZStack {
                VStack {
                    Constants.Skins.xSkin1
                    Text(viewModel.gameWithComputer ? "You" : "Player One")
                    .font(.system(size: 16)).fontWeight(.semibold)
                }
            }
            .frame(width: 103, height: 103)
            .background(Constants.Colors.lightBlue)
            .clipShape(.rect(cornerRadius: 30))
            
            Spacer()
            
            if settingsViewModel.isOnTimer {
                Text(timeString(time: timerViewModel.time) ?? "")
                    .font(.system(size: 20).bold())
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            ZStack {
                VStack {
                    Constants.Skins.oSkin1
                    Text(viewModel.gameWithComputer ? "Computer" : "Player Two")
                        .font(.system(size: 16)).fontWeight(.semibold)
                }
            }
            .frame(width: 103, height: 103)
            .background(Constants.Colors.lightBlue)
            .clipShape(.rect(cornerRadius: 30))
        }
    }
    
    private func timeString(time: Int?) -> String? {
        guard let time else { return nil }
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
}

#Preview {
    HeaderView()
        .environmentObject(GameViewModel(gameWithComputer: true))
}
