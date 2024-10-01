//
//  HeaderView.swift
//  TicTacToe
//
//  Created by Алексей on 30.09.2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            ZStack {
                VStack {
                    Constants.Skins.xSkin1
                    Text("You").font(.system(size: 16)).fontWeight(.semibold)
                }
            }
            .frame(width: 103, height: 103)
            .background(Constants.Colors.lightBlue)
            .clipShape(.rect(cornerRadius: 30))
            
            Spacer()
            
            ZStack {
                VStack {
                    Constants.Skins.oSkin1
                    Text("Player Two").font(.system(size: 16)).fontWeight(.semibold)
                }
            }
            .frame(width: 103, height: 103)
            .background(Constants.Colors.lightBlue)
            .clipShape(.rect(cornerRadius: 30))
        }
    }
}

#Preview {
    HeaderView()
}
