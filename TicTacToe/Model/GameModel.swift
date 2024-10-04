//
//  GameModel.swift
//  TicTacToe
//
//  Created by Алексей on 30.09.2024.
//

import SwiftUI

enum Player {
    case human, anotherHuman, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    var indicator: Image {
        player == .human
            ? Image(UserDefaults.standard.string(forKey: "skin1") ?? "Xskin1")
            : Image(UserDefaults.standard.string(forKey: "skin2") ?? "Oskin1")
    }
}
