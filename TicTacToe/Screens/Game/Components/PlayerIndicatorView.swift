//
//  PlayerIndicatorView.swift
//  TicTacToe
//
//  Created by Алексей on 30.09.2024.
//

import SwiftUI

struct PlayerIndicator: View {
    
    var image: Image?
    
    var body: some View {
        if image != nil {
            image!
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
        }
    }
}
