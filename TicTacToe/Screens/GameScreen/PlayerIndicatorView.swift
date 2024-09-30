//
//  PlayerIndicatorView.swift
//  TicTacToe
//
//  Created by Алексей on 30.09.2024.
//

import SwiftUI

struct PlayerIndicator: View {
    
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}
