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
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        ForEach(0..<4){ rule in
                            HStack(alignment: .top, spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(Constants.Colors.purple)
                                        .frame(width: 45, height: 45)
                                    Text((rule + 1).description)
                                        .font(.system(size: 20))
                                        .foregroundStyle(Constants.Colors.black)
                                }
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 30)
                                        .foregroundStyle(Color.appLightBlue)
                                    Text(rules[rule])
                                        .frame(width: 235, alignment: .topLeading)
                                        .font(.system(size: 18))
                                        .foregroundStyle(Constants.Colors.black)
                                        .padding(.vertical, 12)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.top, 40)
                }
            }
            .setToolBar()
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HowToPlayView()
}
