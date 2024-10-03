//
//  SwiftUIView.swift
//  TicTacToe
//
//  Created by NikitaKorniuk   on 29.09.24.
//

import SwiftUI

struct OnbordingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: HowToPlayView())
                        {
                            Constants.Icons.question
                                .resizable()
                                .frame(width: 36, height: 36)
                        }
                    }
                    
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

                Spacer()
                
                HStack {
                    Constants.Skins.xSkin1
                        .resizable()
                        .frame(width: 108, height: 107)
                        .scaleEffect(isAnimating ? 0.9 : 1.1)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
                    Constants.Skins.oSkin1
                        .resizable()
                        .frame(width: 136, height: 135)
                        .scaleEffect(isAnimating ? 1.1 : 0.9)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
                }
                .padding(.bottom, 20)
                
                Text("Tic Tac Toe")
                    .font(.system(size: 36, weight: .heavy, design: .default))
                    .foregroundColor(.black)
                Spacer()
                
                NavigationLink(destination: SelectGame()){
                    Text("Let's play")
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .frame(width: 348, height: 80)
                        .background(Color.appBlue)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
            }
            .background(Color.white.ignoresSafeArea())
            .onAppear(perform: {
                isAnimating = true
            })
        }
    }
}

#Preview {
    OnbordingView()
}

