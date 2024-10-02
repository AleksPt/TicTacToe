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
    
    func addLeader(_ leaderTime: Int?) {
        guard let leaderTime else { return }
        setLeaders.insert(leaderTime)
        let resultLeader = Array(setLeaders).sorted(by: <)
        DispatchQueue.main.async {
               self.leaders = resultLeader
           }
    }
}
