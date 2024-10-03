//
//  LeaderboardViewModel.swift
//  TicTacToe
//
//  Created by Алексей on 03.10.2024.
//

import SwiftUI

final class LeaderboardViewModel: ObservableObject {
    @Published var leaders: [Int] = []
    
    private var setLeaders: Set<Int> = []
    
    func addLeader(allTime: Int?, newTime: Int?) {
        guard let newTime,
              let allTime else { return }
        let leaderTime = allTime - newTime
        setLeaders.insert(leaderTime)
        let resultLeader = Array(setLeaders).sorted(by: <)
        DispatchQueue.main.async {
               self.leaders = resultLeader
           }
    }
}
