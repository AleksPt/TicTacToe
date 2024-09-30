//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Алексей on 30.09.2024.
//

import SwiftUI

final class GameViewModel: ObservableObject {
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
    @Published var isFinishedGame = false
    private var currentPlayer: Player = .human
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
            // TODO:
            statusGame = currentPlayer == .human ? .win : .winPlayerTwo
            finishedGame()
            return
        }
        
        if checkForDraw(in: moves) {
            // TODO:
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
                // TODO:
                statusGame = .lose
                finishedGame()
                return
            }
            
            if checkForDraw(in: moves) {
                // TODO:
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
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    private func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap {$0}.count == 9
    }
        
    private func finishedGame() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isFinishedGame = true
        }
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        isGameboardDisabled = false
        statusGame = nil
        currentPlayer = .human
    }
}
