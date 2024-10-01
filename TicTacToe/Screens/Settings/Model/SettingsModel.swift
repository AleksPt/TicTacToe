//
//  SettingsModel.swift
//  TicTacToe
//
//  Created by NikitaKorniuk   on 01.10.24.
//

import SwiftUI

enum TimerTime: Int {
    case thirty = 30
    case sexty = 60
    case oneHundredTwenty = 120
}

enum ScinsPlayrs {
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth

    var skins: (Image, Image) {
        switch self {
        case .first:
            return (Constants.Skins.xSkin1, Constants.Skins.oSkin1)
        case .second:
            return (Constants.Skins.xSkin2, Constants.Skins.oSkin2)
        case .third:
            return (Constants.Skins.xSkin3, Constants.Skins.oSkin3)
        case .fourth:
            return (Constants.Skins.xSkin4, Constants.Skins.oSkin4)
        case .fifth:
            return (Constants.Skins.xSkin5, Constants.Skins.oSkin5)
        case .sixth:
            return (Constants.Skins.xSkin6, Constants.Skins.oSkin6)
        }
    }
}
