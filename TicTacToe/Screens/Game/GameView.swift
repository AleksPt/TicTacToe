//
//  GameView.swift
//  TicTacToe
//
//  Created by Алексей on 30.09.2024.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: GameViewModel
    @EnvironmentObject private var timerViewModel: TimerViewModel
    
    var body: some View {
        ZStack {
            Constants.Colors.background
            VStack {
                HeaderView()
                    .environmentObject(timerViewModel)
                .padding(.horizontal, 30)
                .padding(.top, 122)
                
                TurnStatus
                
                GameSquare
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    timerViewModel.pauseTimer()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        resetGame()
                    }
                }, label: {
                    Constants.Icons.back
                })
            }
        }
        .fullScreenCover(
            isPresented: $viewModel.isFinishedGame,
            onDismiss: resetGame
        ) {
            ResultView(
                text: viewModel.statusGame?.title ?? "",
                image: viewModel.statusGame?.image ?? Constants.Icons.win
            )
        }
        .onAppear(perform: {
            timerViewModel.startTimer()
        })
    }
    
    var TurnStatus: some View {
        HStack {
            PlayerIndicator(image: viewModel.currentPlayer == .human
                            ? Constants.Skins.xSkin1
                            : Constants.Skins.oSkin1)
            Text(viewModel.currentPlayer == .human
                 ? viewModel.gameWithComputer ? "Your turn" : "Player One turn"
                 : viewModel.currentPlayer == .computer 
                 ? "Computer turn" : "Player Two turn")
                .font(.system(size: 20).bold())
                .padding(.bottom, 44)
                .padding(.top, 55)
                .offset(y: -4)
        }
    }
    
    var GameSquare: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
                .shadow(color: Constants.Colors.blue.opacity(0.3), radius: 15)
            
            GeometryReader { geometry in
                let width = geometry.size.width
                let point = viewModel.getPointsForLine(width: width)
                ZStack {
                    LazyVGrid(columns: viewModel.columns, spacing: 20) {
                        ForEach(0..<9) { item in
                            ZStack {
                                GameSquareView(proxy: geometry)
                                PlayerIndicator(image: viewModel.moves[item]?.indicator)
                            }
                            .onTapGesture {
                                viewModel.processPlayerMove(for: item)
                            }
                        }
                    }
                }
                .disabled(viewModel.isGameboardDisabled)
                
                if finishGame() {
                    Path { path in
                        path.move(to: CGPoint(x: point.x!.0, y: point.x!.1))
                        path.addLine(to: CGPoint(x: point.y!.0, y: point.y!.1))
                    }
                    .stroke(.pink, lineWidth: 5)
                }
            }
            .padding(20)
        }
        .frame(width: UIScreen.main.bounds.width - 88, height: UIScreen.main.bounds.width - 88)
    }
    
    private func resetGame() {
        viewModel.resetGame()
        timerViewModel.stopTimer()
    }
    
    private func finishGame() -> Bool {
        if viewModel.winPattern != nil {
            timerViewModel.pauseTimer()
           return true
        } else {
            return false
        }
    }
}

#Preview {
    GameView()
        .environmentObject(GameViewModel(gameWithComputer: true))
}
