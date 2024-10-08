//
//  DifficultLevel.swift
//  TicTacToe
//
//  Created by VASILY IKONNIKOV on 02.10.2024.
//

import SwiftUI

struct DifficultLevel: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var activateRootLink: Bool
    
    var body: some View {
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
            .navigationBarBackButtonHidden(true)
    }
    
    var Links: some View {
        VStack {
            NavigationLink(destination: GameView(activateRootLink: $activateRootLink)
                .environmentObject(GameViewModel(gameWithComputer: true))
            ) {
                SelectGameButtton(text: "Hard")
            }
            
            NavigationLink(destination: GameView(activateRootLink: $activateRootLink)
                .environmentObject(GameViewModel(gameWithComputer: true))
            ){
                SelectGameButtton(text: "Standart")
            }
            .padding()
            
            NavigationLink(destination: GameView(activateRootLink: $activateRootLink)
                .environmentObject(GameViewModel(gameWithComputer: true))
            ) {
                SelectGameButtton(text: "Easy")
            }
        }
    }
}

#Preview {
    DifficultLevel(activateRootLink: .constant(false))
}
