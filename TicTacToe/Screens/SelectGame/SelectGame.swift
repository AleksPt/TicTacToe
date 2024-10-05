//
//  SelectGame.swift
//  TicTacToe
//
//  Created by VASILY IKONNIKOV on 02.10.2024.
//

import SwiftUI

struct SelectGame: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var activateRootLink1 = false
    @State private var activateRootLink2 = false
    
    var body: some View {
        NavigationView {
            ZStack {
                    Constants.Colors.background
                    Rectangle()
                        .frame(width: 285, height: 336)
                        .cornerRadius(30)
                        .foregroundColor(.white)
                        .shadow(color: Color(red: 0.6, green: 0.62, blue: 0.76).opacity(0.3), radius: 15, x: 4, y: 4)
                    VStack {
                        Text("Select Game")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(Constants.Colors.black)
                        
                        Links
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
    
    var Links: some View {
        VStack {
            NavigationLink(isActive: $activateRootLink1) {
                DifficultLevel(activateRootLink: $activateRootLink1)
            } label: {
                SelectGameButtton(
                    image: Constants.Icons.singlePlayer,
                    text: "Single Player"
                )
            }
            
            NavigationLink(isActive: $activateRootLink2) {
                GameView(activateRootLink: $activateRootLink2)
                    .environmentObject(GameViewModel(gameWithComputer: false))
            } label: {
                SelectGameButtton(image: Constants.Icons.twoPlayers, text: "Two Players")
                    .padding()
            }
            
            NavigationLink(destination: Leaderboard()) {
                SelectGameButtton(image: Constants.Icons.leaderboard, text: "Leaderboard")
            }
        }
    }
}

#Preview {
    SelectGame()
}
