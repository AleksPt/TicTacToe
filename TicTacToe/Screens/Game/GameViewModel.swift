//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Алексей on 30.09.2024.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    @StateObject private var timerViewModel = TimerViewModel()
    
    enum WinPattern: String, CaseIterable {
        case win012 = "0,1,2"
        case win345 = "3,4,5"
        case win678 = "6,7,8"
        case win036 = "0,3,6"
        case win147 = "1,4,7"
        case win258 = "2,5,8"
        case win048 = "0,4,8"
        case win246 = "2,4,6"
    }
        
    enum StatusGame {
        case win, winPlayerTwo, lose, draw
        
        var title: String {
            switch self {
            case .win:
                "Player One Win!"
            case .winPlayerTwo:
                "Player Two Win!"
            case .lose:
                "Your Lose!"
            case .draw:
                "Draw"
            }
        }
        
        var image: Image {
            switch self {
            case .win, .winPlayerTwo:
                Constants.Icons.win
            case .lose:
                Constants.Icons.lose
            case .draw:
                Constants.Icons.draw
            }
        }
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameboardDisabled = false
    @Published var statusGame: StatusGame?
    @Published var isFinishedGame = false {
        didSet { timerViewModel.pauseTimer() }
    }
    @Published var currentPlayer: Player = .human
    @Published var winPattern: WinPattern?
    private var changingIndex: Int = -1
    var gameWithComputer: Bool
    
    init(gameWithComputer: Bool) {
        self.gameWithComputer = gameWithComputer
    }
    
    func processPlayerMove(for position: Int) {
        if isSquareOccupied(in: moves, index: position) { return }
        changingIndex = position
        
        moves[position] = Move(player: currentPlayer, boardIndex: position)
        
        if checkWinCondition(for: currentPlayer, in: moves) {
            statusGame = currentPlayer == .human ? .win : .winPlayerTwo
            finishedGame()
            return
        }
        
        if checkForDraw(in: moves) {
            statusGame = .draw
            finishedGame()
            return
        }
        
        guard gameWithComputer else {
            currentPlayer = currentPlayer == .human ? .anotherHuman : .human
            return
        }
        
        isGameboardDisabled = true
        currentPlayer = .computer
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)  { [weak self] in
            guard let self else { return }
            let computerMovePosition = determineComputerMovePosition(in: moves)
            changingIndex = computerMovePosition
            
            moves[computerMovePosition] = Move(player: currentPlayer, boardIndex: computerMovePosition)
            
            if checkWinCondition(for: currentPlayer, in: moves) {
                statusGame = .lose
                finishedGame()
                return
            }
            
            if checkForDraw(in: moves) {
                statusGame = .draw
                finishedGame()
                return
            }
            
            isGameboardDisabled = false
            currentPlayer = .human
        }
    }
    
    private func isSquareOccupied(in moves: [Move?], index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index } )
    }
    
    private func determineComputerMovePosition(in moves: [Move?]) -> Int {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, index: winPositions.first!)
                if isAvailable {
                    return winPositions.first!
                }
            }
        }
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, index: winPositions.first!)
                if isAvailable {
                    return winPositions.first!
                }
            }
        }
        
        let centerSquare = 4
        if !isSquareOccupied(in: moves, index: centerSquare) {
            return centerSquare
        }
        
        
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, index: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    private func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
            let arrayPattern = pattern.sorted()
            let stringArray = arrayPattern.map { String($0) }
            let resultString = stringArray.joined(separator: ",")
            WinPattern.allCases.forEach {
                if $0.rawValue == resultString {
                    let temp = $0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
                        withAnimation {
                            self?.winPattern = temp                            
                        }
                    }
                }
            }
            return true
        }
        
        return false
    }
    
    private func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap {$0}.count == 9
    }
        
    private func finishedGame() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
            self?.isFinishedGame = true
        }
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        isGameboardDisabled = false
        statusGame = nil
        currentPlayer = .human
        winPattern = nil
    }
    
    func getPointsForLine(width: CGFloat) -> LinePoints {
        var points = LinePoints()
        
        let firstHorizontalLineStart: (CGFloat, CGFloat) = (x: 0, y: width / 7)
        let firstHorizontalLineFinish: (CGFloat, CGFloat) = (x: width, y: width / 7)
        
        let middleHorizontalLineStart: (CGFloat, CGFloat) = (x: 0, y: width / 2)
        let middleHorizontalLineFinish: (CGFloat, CGFloat) = (x: width, y: width / 2)
        
        let thirdHorizontalLineStart: (CGFloat, CGFloat) = (x: 0, y: width / 1.18)
        let thirdHorizontalLineFinish: (CGFloat, CGFloat) = (x: width, y: width / 1.18)
        
        let bottomLeadingDiagonalLineStart: (CGFloat, CGFloat) = (x: 0, y: width)
        let topTrailingDiagonalLineFinish: (CGFloat, CGFloat) = (x: width, y: 0)
        
        let topLeadingDiagonalLineStart: (CGFloat, CGFloat) = (x: 0, y: -5)
        let bottomTrailingDiagonalLineFinish: (CGFloat, CGFloat) = (x: width, y: width)
        
        let firstVerticalLineStart: (CGFloat, CGFloat) = (x: width / 6.5, y: -5)
        let firstVerticalLineFinish: (CGFloat, CGFloat) = (x: width / 6.5, y: width)
        
        let middleVerticalLineStart: (CGFloat, CGFloat) = (x: width / 2, y: -5)
        let middleVerticalLineFinish: (CGFloat, CGFloat) = (x: width / 2, y: width)
        
        let thirdVerticalLineStart: (CGFloat, CGFloat) = (x: width / 1.18, y: -5)
        let thirdVerticalLineFinish: (CGFloat, CGFloat) = (x: width / 1.18, y: width)
        
        switch winPattern {
        case .win012:
            points.x = firstHorizontalLineStart
            points.y = firstHorizontalLineFinish
        case .win345:
            points.x = middleHorizontalLineStart
            points.y = middleHorizontalLineFinish
        case .win678:
            points.x = thirdHorizontalLineStart
            points.y = thirdHorizontalLineFinish
        case .win036:
            points.x = firstVerticalLineStart
            points.y = firstVerticalLineFinish
        case .win147:
            points.x = middleVerticalLineStart
            points.y = middleVerticalLineFinish
        case .win258:
            points.x = thirdVerticalLineStart
            points.y = thirdVerticalLineFinish
        case .win048:
            points.x = topLeadingDiagonalLineStart
            points.y = bottomTrailingDiagonalLineFinish
        case .win246:
            points.x = bottomLeadingDiagonalLineStart
            points.y = topTrailingDiagonalLineFinish
        case .none:
            break
        }
        
        return points
    }
}
