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
    @Published var currentSkin: Int?
    @Published var currentMusic: String?
    @Published var isOnMusic: Bool = false
    @Published var classicMusic = false
    @Published var instrumentalMusic = false
    @Published var natureMusic = false
    @Published var limit30 = false
    @Published var limit60 = false
    @Published var limit120 = false
    @Published var gameLimit = 0
    
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
