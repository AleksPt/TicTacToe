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
            .padding(.trailing,210) 
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
    @EnvironmentObject private var settingsViewModel: SettingsViewModel
    @EnvironmentObject private var timerViewModel: TimerViewModel
    @EnvironmentObject private var audioService: AudioService
    
    @Environment(\.presentationMode) var presentationMode
    @State private var gameTime = false
    @State private var gameMusic = false
    
    @State private var gameTimeStandBy = true
    @State private var gameMusicStandBy = true
    
    @State private var gameLimit = 0
    @State private var currentMusic = ""
    
    @State private var limit30 = false
    @State private var limit60 = false
    @State private var limit120 = false
    
    @State private var classicMusic = false
    @State private var instrumentalMusic = false
    @State private var natureMusic = false
    
    @State private var currentIcons = 0
    
    let icons = [ ["Xskin1","Oskin1" ], ["Xskin2","Oskin2"], ["Xskin3","Oskin3"], ["Xskin4","Oskin4"],["Xskin5","Oskin5"], ["Xskin6","Oskin6"] ]
    
    let layout = [ GridItem(.fixed(152), spacing: 20),
                   GridItem(.fixed(152)) ]
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundStyle(.white)
                            VStack {
                                DisclosureGroupDuration
                                DisclosureGroupMusic
                            }
                        }
                        .frame(width:348)
                    }
                    GridsView
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("backIcon")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .font(.title).fontWeight(.bold)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    var DisclosureGroupDuration: some View {
        VStack {
            ZStack { RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(Color.appLightBlue)
                Toggle(isOn: $settingsViewModel.isOnTimer) {
                    Text("Game Time")
                        .font(.system(size: 20))
                }.onChange(of: settingsViewModel.isOnTimer, perform: { value in
                    settingsViewModel.isOnTimer = value
                })
                .tint(Color.appBlue)
                .padding(20)
            }.frame(width:308, height: 69)
                .padding(.top,20)
                .padding(.bottom,20)
            
            if settingsViewModel.isOnTimer {
                ZStack() {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(Color.appLightBlue)
                        .frame(width: 308)
                    
                    
                    VStack() {
                        DisclosureGroup( isExpanded: $gameTimeStandBy) {
                            VStack( spacing: 0) {
                                
                                Divider()
                                    .background(Color.appBlue)
                                
                                Toggle(isOn: $limit30) {
                                    Text("30 sec")
                                        .setToogleText()
                                } .onChange(of: limit30, perform:  { _ in
                                    if limit30 {
                                        settingsViewModel.inputTimer(.thirty)
                                        gameLimit = 30
                                        timerViewModel.timeValue = gameLimit
                                        limit60 = false
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
                                        settingsViewModel.inputTimer(.sixty)
                                        gameLimit = 60
                                        timerViewModel.timeValue = gameLimit
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
                                        settingsViewModel.inputTimer(.oneHundredTwenty)
                                        gameLimit = 120
                                        timerViewModel.timeValue = gameLimit
                                        limit60 = false
                                        limit30 = false
                                    }
                                })
                                .background(limit120 ? Color.appPurple : .clear)
                                .toggleStyle(.button)
                                .padding(.bottom, 20)
                                
                            }//VStack
                        } label: {
                            HStack {
                                Text("Duration")
                                    .font(.system(size: 20))
                                    .tint(Color.black)
                                    .padding(.leading,20)
                                    .frame(height: 61)
                                Spacer()
                                Text(checkDuration(limits: limit30, limit60, limit120) ? "\(String(gameLimit)) sec" : " ")
                                    .tint(Color.black)
                                    .font(.system(size: 20))
                            }
                            
                        }.accentColor(.clear)
                    }
                }
                .padding(.bottom,20)
                .frame(width: 308)
            }
        }
    }
    
    var DisclosureGroupMusic: some View {
        VStack {
            ZStack { RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(Color.appLightBlue)
                Toggle(isOn: $audioService.isPlaySound) {
                    Text("Music")
                        .font(.system(size: 20))
                }
                .tint(Color.appBlue)
                .padding(20)
            }.frame(width:308, height: 69)
                .padding(.bottom,20)
            
            
            if audioService.isPlaySound {
                ZStack() {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(Color.appLightBlue)
                        .frame(width: 308)
                    
                    VStack() {
                        DisclosureGroup( isExpanded: $gameMusicStandBy) {
                            VStack( spacing: 0) {
                                
                                Divider()
                                    .background(Color.appBlue)
                                
                                Toggle(isOn: $classicMusic) {
                                    Text("Classical")
                                        .padding(.trailing,190)
                                        .font(.system(size: 20))
                                        .frame(width:282, height: 40)
                                        .tint(.black)
                                } .onChange(of: classicMusic,perform:  { _ in
                                    if classicMusic {
                                        currentMusic = "Classical"
                                        instrumentalMusic = false
                                        natureMusic = false
                                    }
                                })
                                .background(classicMusic ? Color.appPurple : .clear)
                                .toggleStyle(.button)
                                
                                Toggle(isOn: $instrumentalMusic) {
                                    Text("Instrumentals")
                                        .padding(.trailing,150)
                                        .font(.system(size: 20))
                                        .frame(width:282, height: 40)
                                        .tint(.black)
                                }.onChange(of: instrumentalMusic, perform:  { _ in
                                    if instrumentalMusic {
                                        currentMusic = "Instrumental"
                                        classicMusic = false
                                        natureMusic = false
                                    }
                                })
                                .background(instrumentalMusic ? Color.appPurple : .clear)
                                .toggleStyle(.button)
                                
                                Toggle(isOn: $natureMusic) {
                                    Text("Nature")
                                        .setToogleText()
                                }.onChange(of: natureMusic, perform: { _ in
                                    if natureMusic {
                                        currentMusic = "Nature"
                                        classicMusic = false
                                        instrumentalMusic = false
                                    }
                                })
                                .background(natureMusic ? Color.appPurple : .clear)
                                .toggleStyle(.button)
                                .padding(.bottom, 20)
                                
                            }
                        } label: {
                            HStack {
                                Text("Select Music")
                                    .font(.system(size: 20))
                                    .tint(Color.black)
                                    .padding()
                                    .frame(height: 61)
                                Spacer()
                                Text(checkMusic(musics: classicMusic, instrumentalMusic, natureMusic)  ? currentMusic : "")
                                    .tint(Color.black)
                                    .font(.system(size: 20))
                            }
                        }.accentColor(.clear)
                    }
                }.padding(.bottom,20)
                    .frame(width: 308)
            }
        }
    }
    
    var GridsView: some View {
        VStack() {
            LazyVGrid(columns: layout, spacing: 20) {
                ForEach(0..<6){ number in
                    Button(action: {
                        currentIcons = number
                        saveSkins(
                            firstSkin: icons[number].first,
                            secondSkin: icons[number].last
                        )
                    } ) {
                        PickShape(picked: currentIcons == number ? true : false, playerIcons: icons[number])
                    }
                }
            }
        }
        .frame(width: 324, height: 490)
        .padding(.top,40)
    }
    
    private func checkDuration(limits: Bool... )-> Bool {
        if limits.contains(true) {
            return true
        }
        return false
    }
    
    private func checkMusic(musics: Bool...)-> Bool {
        let check = musics.contains(true) ? true : false
        return check
    }
    
    private func saveSkins(firstSkin: String?, secondSkin: String?) {
        if let firstSkin = firstSkin,
           let secondSkin  = secondSkin {
            let firstImage = Image(firstSkin)
            let secondImage = Image(secondSkin)
            settingsViewModel.selectedSkins = (firstImage, secondImage)
        }
    }
}

#Preview {
    SettingsGameView()
}
