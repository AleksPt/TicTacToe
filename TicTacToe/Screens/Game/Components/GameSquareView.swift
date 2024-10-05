//
//  GameSquareView.swift
//  TicTacToe
//
//  Created by Алексей on 30.09.2024.
//

import SwiftUI

struct GameSquareView: View {
    
    var proxy: GeometryProxy
     
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(
                width: proxy.size.width / 3 - 15,
                height: proxy.size.width / 3 - 15
            )
            .foregroundColor(Constants.Colors.lightBlue)
    }
}
