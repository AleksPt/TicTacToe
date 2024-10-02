//
//  SelectGame.swift
//  TicTacToe
//
//  Created by VASILY IKONNIKOV on 02.10.2024.
//

import SwiftUI

struct SelectGame: View {
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .frame(width: 285, height: 247)
                    .cornerRadius(30)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                
                VStack {
                    Text("Select Game")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Constants.Colors.black)
                    
                    SelectGameButtton(image: Constants.Icons.singlePlayer, text: "Single Player")
                    SelectGameButtton(image: Constants.Icons.twoPlayers, text: "Two Players", isSelected: false)
                        .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingsGameView()
                    } label: {
                        Constants.Icons.settings
                            .resizable()
                            .frame(width: 36, height: 36)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SelectGame()
}
