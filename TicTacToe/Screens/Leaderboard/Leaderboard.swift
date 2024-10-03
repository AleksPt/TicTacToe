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
    @State private var isPresented: Bool = false
    @State private var leaders: [Leader] = [] /*[Leader(time: "10:15"), Leader(time: "10:16"), Leader(time: "10:17"), Leader(time: "10:18"), Leader(time: "10:19")]*/
    
    var body: some View {
        VStack {
            if leaderboardVM.leaders.isEmpty {
                VStack {
                    Text("No game history\nwith turn on time")
                        .font(.system(size: 20))
                    Constants.Backgrounds.emptyLeaderboard
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
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("backIcon")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Leaderboard()
}
