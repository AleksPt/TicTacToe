//
//  HowToPlayView.swift
//  TicTacToe
//
//  Created by Marat Fakhrizhanov on 30.09.2024.
//

import SwiftUI

struct InlineMod: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("How to play")
                        .font(.title).fontWeight(.bold)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("backIcon")
                    }
                }
            }
    }
}
extension View {
    func setToolBar() -> some View {
        modifier(InlineMod())
    }
}


struct HowToPlayView: View {
    
    let rules: [String] = ["Draw a grid with three rows and three columns, creating nine squares in total.",
                           "Players take turns placing their marker (X or O) in an empty square. To make a move, a player selects a number corresponding to the square where they want to place their marker.",
                           "Player X starts by choosing a square (e.g., square 5). Player O follows by choosing an empty square (e.g., square1). Continue alternating turns until the game ends.",
                           "The first player to align three of their markers horizontally, vertically, or diagonally wins. Examples of Winning Combinations:\nHorizontal: Squares 1, 2, 3 or 4,5,6 or 7,8,9\nVertical: Squares 1, 4, 7 or 2, 5,8 ог 3,6,9\nDiagonal: Squares 1, 5, 9 or 3, 5,7."]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        ForEach(0..<4){ rule in
                            HStack(alignment: .top, spacing: 16) {
                                Image(systemName: "\(String(rule + 1)).circle.fill") // из системных картинок, можно кастомную самому нарисовать ...
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .background(Color.black)
                                    .foregroundStyle(Color.appPurple)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(.white , lineWidth: 2)) 
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 30)
                                        .foregroundStyle(Color.appLightBlue)
                                    Text(rules[rule])
                                        .font(.title3)
                                        .tint(Color.black)
                                        .padding(10)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .setToolBar()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HowToPlayView()
}
