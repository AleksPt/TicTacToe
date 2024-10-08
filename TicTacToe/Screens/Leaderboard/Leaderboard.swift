//
//  Leaderboard.swift
//  TicTacToe
//
//  Created by VASILY IKONNIKOV on 02.10.2024.
//

import SwiftUI

struct Leaderboard: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var leaderboardVM: LeaderboardViewModel
    @State private var offset: CGFloat = 25

    
    var body: some View {
        VStack {
            if leaderboardVM.leaders.isEmpty {
                VStack {
                    Text("No game history\nwith turn on time")
                        .font(.system(size: 20))
                    Constants.Backgrounds.emptyLeaderboard
                        .offset(y: offset)
                        .animation(Animation.easeInOut(duration: 1)
                            .repeatForever(autoreverses: true), value: offset)
                        .onAppear {
                            offset = 20
                        }

                }
            } else {
                LeadersView(leaders: leaderboardVM.leaders)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Leaderboard")
                    .font(.title).fontWeight(.bold)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("backIcon")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                if !leaderboardVM.leaders.isEmpty {
                    Button("Reset") {
                        withAnimation {
                            leaderboardVM.leaders = []
                            leaderboardVM.clearHistory()
                        }
                    }
                    .tint(.pink)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Leaderboard()
}
