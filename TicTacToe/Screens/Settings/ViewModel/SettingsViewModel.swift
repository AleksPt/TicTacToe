//
//  SettingsViewModel.swift
//  TicTacToe
//
//  Created by NikitaKorniuk   on 01.10.24.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    //MARK: - Property
    @Published var timer: TimerTime? = nil
    @Published var isOnTimer = true {
        didSet{ timer = isOnTimer ? TimerTime.thirty : nil }
    }
//    @Published var timer: TimerTime? = .sixty
//    @Published var isOnTimer = true {
//        didSet{ timer = isOnTimer ? TimerTime.thirty : nil }
//    }
    @Published var selectedSkins: (Image,Image) = (Constants.Skins.xSkin1, Constants.Skins.oSkin1)
    
    //MARK: - Method's
    func isOnTimer(_ isOn: Bool) {
        isOnTimer = isOn
    }
    
    func inputTimer(_ time: TimerTime) {
        timer = time
    }
    
    func selectSkins(_ skins: ScinsPlayrs){
        selectedSkins = skins.skins
    }
}
