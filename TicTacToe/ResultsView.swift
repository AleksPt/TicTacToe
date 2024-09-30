//
//  ResultsView.swift
//  TicTacToe
//
//  Created by Marat Fakhrizhanov on 30.09.2024.
//

import SwiftUI

enum ResultButton: String {
    case playAgain = "Play again"
    case back = "Back"
}

struct ResultViewButton: View {
    var button: ResultButton
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack{
                RoundedRectangle(cornerRadius: 35)
                    .frame(width: 348, height: 80)
                    .foregroundStyle(button == ResultButton.back ? Color.white : Color.appBlue)
                Text(button.rawValue)
                    .font(.system(size: 25,weight: .heavy, design: .default))
                    .tint(button == ResultButton.back ? Color.appBlue : Color.white)
                    .frame(width: 348, height: 80)
                    .overlay(RoundedRectangle(cornerRadius: 35).stroke(.appBlue, lineWidth: 2.5))
            }
        }
    }
}

struct ResultView: View {
    var text: String // binding ?
    var image: String // or Image
    
    var body: some View {
        
        Spacer()
        
       Text(text)
            .font(.system(size: 25,weight: .heavy, design: .default))
        
        ZStack{
            Color.appBlue
            Image(image)
        }.frame(width: 228, height: 228)
            .clipShape(Circle())
        
        Spacer()
        
        VStack(spacing: 16) {
            ResultViewButton(button: .playAgain, action: playAgain)
            ResultViewButton(button: .back, action: returnToOnbourding)
        }.padding(.bottom, 30)
    }
    
    func returnToOnbourding() {
        // back to onboarding view
    }
    
    func playAgain() {
        // play again/revange
    }
}

#Preview {
    ResultView(text:"Draw!", image: "drawIcon")
}
