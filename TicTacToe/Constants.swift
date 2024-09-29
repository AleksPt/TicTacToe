//
//  Constants.swift
//  TicTacToe
//
//  Created by Алексей on 29.09.2024.
//

import SwiftUI

enum Constants {
    enum Colors {
        static let background = Color(.appBackground)
        static let lightBlue = Color(.appLightBlue)
        static let blue = Color(.appBlue)
        static let black = Color(.appBlack)
        static let purple = Color(.appPurple)
        static let pink = Color(.appPink)
        static let gray = Color(.appGray)
    }
    
    enum Icons {
        static let win = Image(.winIcon)
        static let draw = Image(.drawIcon)
        static let lose = Image(.loseIcon)
        static let singlePlayer = Image(.singlePlayerIcon)
        static let twoPlayers = Image(.twoPlayerIcon)
        static let leaderboard = Image(.leaderboardIcon)
        static let settings = Image(.settingIcon)
        static let back = Image(.backIcon)
        static let question = Image(.questionIcon)
    }
    
    enum Skins {
        static let xSkin1 = Image(.xskin1)
        static let xSkin2 = Image(.xskin2)
        static let xSkin3 = Image(.xskin3)
        static let xSkin4 = Image(.xskin4)
        static let xSkin5 = Image(.xskin5)
        static let xSkin6 = Image(.xskin6)
        static let oSkin1 = Image(.oskin1)
        static let oSkin2 = Image(.oskin2)
        static let oSkin3 = Image(.oskin3)
        static let oSkin4 = Image(.oskin4)
        static let oSkin5 = Image(.oskin5)
        static let oSkin6 = Image(.oskin6)
    }
}
