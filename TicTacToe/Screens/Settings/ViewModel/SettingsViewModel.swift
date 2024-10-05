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
    @AppStorage(Constants.KeysUD.isOnTimer) var isOnTimer = false
    @Published var selectedSkins: (Image,Image) = (
        Image(UserDefaults.standard.string(forKey: Constants.KeysUD.skin1) ?? "Xskin1"),
        Image(UserDefaults.standard.string(forKey: Constants.KeysUD.skin2) ?? "Oskin1")
    )
    
    @AppStorage(Constants.KeysUD.currentSkin) var currentSkin: Int?
    @AppStorage(Constants.KeysUD.currentMusic) var currentMusic: String?
    @AppStorage(Constants.KeysUD.isOnMusic) var isOnMusic: Bool = false
    
    @AppStorage(Constants.KeysUD.classicMusic) var classicMusic = false
    @AppStorage(Constants.KeysUD.instrumentalMusic) var instrumentalMusic = false
    @AppStorage(Constants.KeysUD.natureMusic) var natureMusic = false
    @AppStorage(Constants.KeysUD.limit5) var limit5 = false
    @AppStorage(Constants.KeysUD.limit30) var limit30 = false
    @AppStorage(Constants.KeysUD.limit60) var limit60 = false
//    @AppStorage(Constants.KeysUD.gameLimit) var gameLimit = 0
    @Published var gameLimit = UserDefaults.standard.integer(forKey: Constants.KeysUD.gameLimit) {
        didSet {
            UserDefaults.standard.set(gameLimit, forKey: Constants.KeysUD.gameLimit)
        }
    }
    
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
        UserDefaults.standard.setValue(skin1, forKey: Constants.KeysUD.skin1)
        UserDefaults.standard.setValue(skin2, forKey: Constants.KeysUD.skin2)
    }
}
