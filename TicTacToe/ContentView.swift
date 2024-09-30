//
//  ContentView.swift
//  TicTacToe
//
//  Created by Алексей on 29.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            
            NavigationLink("1 Player") {
                GameView()
                    .environmentObject(GameViewModel(gameWithComputer: true))
            }
            
            NavigationLink("2 Player") {
                GameView()
                    .environmentObject(GameViewModel(gameWithComputer: false))
            }
        }
    }
}

#Preview {
    ContentView()
}
