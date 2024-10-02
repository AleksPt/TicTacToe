//
//  SettingsViewModel.swift
//  TicTacToe
//
//  Created by NikitaKorniuk   on 01.10.24.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    //MARK: - Property
    @Published var timer: TimerTime?
    @Published var isOnTimer = false
    @Published var selectedSkins: (Image,Image) = (Constants.Skins.xSkin1, Constants.Skins.oSkin1)
    
    @Published var time30 = false
    @Published var time60 = false
    @Published var time120 = false
    
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
