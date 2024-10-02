//
//  SettingsView.swift
//  TicTacToe
//
//  Created by Marat Fakhrizhanov on 01.10.2024.
//

import SwiftUI

struct PickShape: View {
    let picked: Bool
    let playerIcons: [String]
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 152, height: 150)
                .foregroundStyle(Color.white)
            
            HStack(spacing: 2) {
                ForEach(playerIcons, id: \.self) { icon in
                    Image(icon)
                        .frame(width: 54, height: 53, alignment: .leading)
                }
            }
            .offset(y: -30) // ~
            
                ZStack()  {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 112, height: 39)
                        .foregroundStyle(picked ? Color.appBlue : Color.appLightBlue)
                    Text( picked ? "Picked" : "Choose")
                        .tint(Color.black)
                        .font(.system(size: 16))
                }
                .offset(y: 30)
        }
    }
}

struct ToggleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.trailing,210) // ~ что бы текст сместился влево
            .font(.system(size: 20))
            .frame(width:282, height: 40)
            .tint(.black)
    }
}
extension View {
    func setToogleText() -> some View {
        modifier(ToggleText())
    }
}

struct SettingsGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var gameTime = true // включена игра на время
    
    @State private var durationStandBy = false
    
    @State private var gameLimit = 30 // текуший выбор пользователя по продолжительности игры
    
    @State private var limit30 = false
    @State private var limit60 = false // для изменения состояния Toggle
    @State private var limit120 = false
    
    @State private var currentIcons = 0 // индекс массива иконок, которые выбраны пользователем
    
    let icons = [ ["Xskin1","Oskin1" ], ["Xskin2","Oskin2"], ["Xskin3","Oskin3"], ["Xskin4","Oskin4"],["Xskin5","Oskin5"], ["Xskin6","Oskin6"] ]
    
    let layout = [ GridItem(.fixed(152), spacing: 20),//20 - расстояние между ячейками
                   GridItem(.fixed(152)) ] // устанавливает ширину ячеек в грид
    
    var body: some View {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundStyle(.white)
                            VStack {
                                ZStack { RoundedRectangle(cornerRadius: 30)
                                        .foregroundStyle(Color.appLightBlue)
                                    Toggle(isOn: $gameTime) {
                                        Text("Game Time")
                                            .font(.system(size: 20))
                                    }
                                    .tint(Color.appBlue)
                                    .padding(20)
                                }.frame(width:308, height: 70)
                                    .padding(20)
                                
                                //MARK: - DisclosureGroup
                                if gameTime {
                                    ZStack() {
                                        RoundedRectangle(cornerRadius: 30)
                                            .foregroundStyle(Color.appLightBlue)
                                            .frame(width: 308)
                                                                               
                                        VStack() {
                                            DisclosureGroup( isExpanded: $gameTime) { // либо сделать зависимым от св-ва Свитча и будет открыт всегда когда включен таймер , заменить на (gameTime) как понравится команде так и оставим.
                                                VStack( spacing: 0) {
                                                    
                                                    Divider()
                                                        .background(Color.appBlue)
                                                        
                                                    Toggle(isOn: $limit30) {
                                                        Text("30 sec")
                                                            .setToogleText()
                                                    } .onChange(of: limit30,perform:  { _ in
                                                        if limit30 {
                                                            gameLimit = 30 // отдаем значение для исп. в таймере
                                                            limit60 = false // тушим и фолсим другие лимиты
                                                            limit120 = false
                                                        }
                                                    })
                                                    .background(limit30 ? Color.appPurple : .clear)
                                                    .toggleStyle(.button)
                                                    
                                                    Toggle(isOn: $limit60) {
                                                        Text("60 sec")
                                                            .setToogleText()
                                                    }.onChange(of: limit60, perform:  { _ in
                                                        if limit60 {
                                                        gameLimit = 60
                                                        limit30 = false
                                                        limit120 = false
                                                    }
                                                    })
                                                    .background(limit60 ? Color.appPurple : .clear)
                                                    .toggleStyle(.button)
                                                    
                                                    Toggle(isOn: $limit120) {
                                                        Text("120 sec")
                                                            .setToogleText()
                                                    }.onChange(of: limit120, perform: { _ in
                                                        if limit120 {
                                                        gameLimit = 120
                                                        limit60 = false
                                                        limit30 = false
                                                    }
                                                    })
                                                    .background(limit120 ? Color.appPurple : .clear)
                                                    .toggleStyle(.button)
                                                    .padding(.bottom, 20)
                                                    
                                                }//VStack
                                            } label: {
                                                Text("Duration")
                                                    .font(.system(size: 20))
                                                    .tint(Color.black)
                                                    .padding()
                                            }.accentColor(.clear)
//                                            .buttonStyle(PlainButtonStyle()).accentColor(.gray).disabled(true)
                                        }
                                    }.padding(.bottom,20)
                                    .frame(width: 308)
                                } //if
                            }
                        }
                        .frame(width:348)
                    }
                    
                    //MARK: - GridsView
                    
                    VStack() {
                        LazyVGrid(columns: layout, spacing: 20) {
                            ForEach(0..<6){ number in
                                Button(action: {
                                    currentIcons = number
                                    print("\(number)")
                                } ) {
                                    PickShape(picked: currentIcons == number ? true : false, playerIcons: icons[number])
                                }
                            }
                        }
                    }
                    .frame(width: 324, height: 490)
                    .padding(.top,40)
                } // ScrollView
            } // ZStack Color fill
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("backIcon")
                    }
                }
            }
    }
    
    private func chooseTimeLimit(for toogle: Bool) {
      // onChange в Toogle упростить и вынести в эту ф-ию
    }
}

#Preview {
    SettingsGameView()
}
