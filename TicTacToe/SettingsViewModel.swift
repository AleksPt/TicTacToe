//
//  SettingsViewModel.swift
//  TicTacToe
//
//  Created by NikitaKorniuk   on 01.10.24.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    //MARK: - Property
    private var timer: TimerTime? = nil
    private var isOnTimer = false {
        didSet{
            timer = isOnTimer ? TimerTime.thirty : nil
        }
    }
    private var selectedSkins: (Image,Image) = (Constants.Skins.xSkin1, Constants.Skins.oSkin1)
    
    //MARK: - Private Method's
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
