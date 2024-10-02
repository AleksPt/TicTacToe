//
//  SelectGameButton.swift
//  TicTacToe
//
//  Created by VASILY IKONNIKOV on 02.10.2024.
//

import SwiftUI

struct SelectGameButtton: View {
    var image: Image
    var text: String
    var isSelected: Bool = true
    
    var body: some View {
        NavigationLink(destination: GameView()
            .environmentObject(GameViewModel(gameWithComputer: isSelected))
        ) {
            HStack {
                image
                Text(text)
            }
            .font(.system(size: 20, weight: .medium, design: .default))
            .frame(width: 245, height: 69)
            .background(Color.appLightBlue)
            .foregroundColor(Constants.Colors.black)
            .cornerRadius(30)
        }
    }
}

#Preview {
    SelectGameButtton(image: Constants.Icons.singlePlayer, text: "Single Player")
}
