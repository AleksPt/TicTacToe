//
//  SwiftUIView.swift
//  TicTacToe
//
//  Created by NikitaKorniuk   on 29.09.24.
//

import SwiftUI

struct OnbordingView: View {
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            
                        }) {
                            Constants.Icons.question
                                .resizable()
                                .frame(width: 36, height: 36)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            
                        }) {
                            Constants.Icons.settings
                                .resizable()
                                .frame(width: 36, height: 36)
                        }
                    }
                }

                Spacer()
                
                HStack {
                    Constants.Skins.xSkin1
                        .resizable()
                        .frame(width: 108, height: 107)
                    Constants.Skins.oSkin1
                        .resizable()
                        .frame(width: 136, height: 135)
                }
                .padding(.bottom, 20)
                
                Text("Tic Tac Toe")
                    .font(.system(size: 36, weight: .heavy, design: .default))
                    .foregroundColor(.black)
                Spacer()
                
                NavigationLink(destination: GameView()){
                    Text("Let's play")
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .frame(width: 348, height: 80)
                        .background(Color.appBlue)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
            }
            .background(Color.white.ignoresSafeArea())
        }
    }
}

#Preview {
    OnbordingView()
}

