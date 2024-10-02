//
//  SelectGame.swift
//  TicTacToe
//
//  Created by VASILY IKONNIKOV on 02.10.2024.
//

import SwiftUI

struct SelectGame: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Constants.Colors.background
                Rectangle()
                    .frame(width: 285, height: 247)
                    .cornerRadius(30)
                    .foregroundColor(.white)
                    .shadow(color: Color(red: 0.6, green: 0.62, blue: 0.76).opacity(0.3), radius: 15, x: 4, y: 4)
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
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Constants.Icons.back
                    })
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
