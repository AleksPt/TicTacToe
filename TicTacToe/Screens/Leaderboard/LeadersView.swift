//
//  LeadersView.swift
//  TicTacToe
//
//  Created by VASILY IKONNIKOV on 02.10.2024.
//

import SwiftUI

struct LeadersView: View {
    var leaders: [Int]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(0..<leaders.count, id: \.self) { index in
                HStack {
                    ZStack {
                        Circle()
                            .fill(index == 0
                                  ? Constants.Colors.purple
                                  : Constants.Colors.lightBlue)
                            .frame(width: 69)
                        Text((index + 1).description)
                            .font(.system(size: 20))
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(index == 0
                                  ? Constants.Colors.purple
                                  : Constants.Colors.lightBlue)
                        HStack {
                            Text(index == 0
                                 ? "Best time: \(String(describing: timeString(time: leaders[index])))"
                                 : "Time: \(String(describing: timeString(time: leaders[index])))")
                                .padding(.leading, 24)
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 21)
            }
        }
        .padding(.top, 40)
        .frame(maxWidth: .infinity)
        .background(Constants.Colors.background)
    }
    
    private func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        let result = String(format: "%01d:%02d", minutes, seconds)
        return result
    }
}

#Preview {
    LeadersView(leaders: [111,222,333,444])
}
