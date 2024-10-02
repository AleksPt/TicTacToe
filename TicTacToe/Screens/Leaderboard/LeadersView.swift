//
//  LeadersView.swift
//  TicTacToe
//
//  Created by VASILY IKONNIKOV on 02.10.2024.
//

import SwiftUI

struct LeadersView: View {
    var leaders: [Leader]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(0..<leaders.count, id: \.self) { leader in
                HStack {
                    Image(systemName: "\(leader + 1).circle.fill")
                        .resizable()
                        .frame(width: 69, height: 69)
                        .background(Color.black)
                        .foregroundStyle(Constants.Colors.lightBlue)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.white , lineWidth: 2))
                    
                    Text("Best time: \(leaders[leader].time)")
                        .frame(width: 269, height: 69)
                        .font(.system(size: 16, weight: .medium))
                        .background(Constants.Colors.lightBlue)
                        .foregroundColor(.black)
                        .cornerRadius(30)
                }
            }
        }
    }
}

#Preview {
    LeadersView(leaders: [Leader(time: "10:10"), Leader(time: "10:10"), Leader(time: "10:10")])
}
