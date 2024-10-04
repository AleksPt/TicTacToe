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
    @Published var selectedSkins: (Image,Image) = (
        Image(UserDefaults.standard.string(forKey: "skin1") ?? "Xskin1"),
        Image(UserDefaults.standard.string(forKey: "skin2") ?? "Oskin1")
    )
    @Published var currentSkin: Int? = UserDefaults.standard.integer(forKey: "currentSkin") {
        didSet {
            UserDefaults.standard.setValue(currentSkin, forKey: "currentSkin")
        }
    }
    @Published var currentMusic: String?
    @Published var isOnMusic: Bool = false
    @Published var classicMusic = false
    @Published var instrumentalMusic = false
    @Published var natureMusic = false
    @Published var limit5 = false
    @Published var limit30 = false
    @Published var limit60 = false
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
    
    func saveSkinsIntoUD(skin1: String, skin2: String) {
        UserDefaults.standard.setValue(skin1, forKey: "skin1")
        UserDefaults.standard.setValue(skin2, forKey: "skin2")
    }
}
