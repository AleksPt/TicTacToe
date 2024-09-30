//
//  GameModel.swift
//  TicTacToe
//
//  Created by Алексей on 30.09.2024.
//

import SwiftUI

enum Player {
    case human,computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    var indicator: Image {
        player == .human ? Constants.Skins.xSkin1 : Constants.Skins.oSkin1
    }
}
