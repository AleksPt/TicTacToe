//
//  Leaderboard.swift
//  TicTacToe
//
//  Created by VASILY IKONNIKOV on 02.10.2024.
//

import SwiftUI

struct Leaderboard: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresented: Bool = false
    @State private var leaders: [Leader] = [] //[Leader(time: "10:15"), Leader(time: "10:16"), Leader(time: "10:17"), Leader(time: "10:18"), Leader(time: "10:19")]
    
    var body: some View {
        NavigationView {
            if leaders.isEmpty {
                VStack {
                    Text("No game history\nwith turn on time")
                        .font(.system(size: 20))
                    Constants.Backgrounds.emptyLeaderboard
                }
            } else {
                LeadersView(leaders: leaders)
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
