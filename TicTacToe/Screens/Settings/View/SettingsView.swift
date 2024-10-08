//
//  SettingsView.swift
//  TicTacToe
//
//  Created by Marat Fakhrizhanov on 01.10.2024.
//

import SwiftUI

struct PickShape: View {
    
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
            .offset(y: -30)
            
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
                    
    let icons = [ ["Xskin1","Oskin1" ], ["Xskin2","Oskin2"], ["Xskin3","Oskin3"], ["Xskin4","Oskin4"],["Xskin5","Oskin5"], ["Xskin6","Oskin6"] ]
    
    let layout = [ GridItem(.fixed(152), spacing: 20),
                   GridItem(.fixed(152)) ]
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
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
                    .padding(.top, 40)
                    .frame(width:348)
                }
                GridsView
            }
        }
        .shadow(color: Color(red: 0.6, green: 0.62, blue: 0.76).opacity(0.3), radius: 15, x: 4, y: 4)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    audioService.stop()
                }) {
                    Image("backIcon")
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Settings")
                    .font(.title).fontWeight(.bold)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var DisclosureGroupDuration: some View {
        VStack {
            ZStack { RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(Color.appLightBlue)
                Toggle(isOn: $settingsViewModel.isOnTimer.animation(.bouncy)) {
                    Text("Game Time")
                        .font(.system(size: 20).bold())
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
                                
                                Toggle(isOn: $settingsViewModel.limit5) {
                                    Text("5 sec")
                                        .setToogleText()
                                } .onChange(of: settingsViewModel.limit5, perform:  { _ in
                                    if settingsViewModel.limit5 {
                                        settingsViewModel.inputTimer(.thirty)
                                        settingsViewModel.gameLimit = 5
                                        timerViewModel.timeValue = settingsViewModel.gameLimit
                                        settingsViewModel.limit30 = false
                                        settingsViewModel.limit60 = false
                                    }
                                })
                                .background(settingsViewModel.limit5 ? Color.appPurple : .clear)
                                .toggleStyle(.button)
                                
                                Toggle(isOn: $settingsViewModel.limit30) {
                                    Text("30 sec")
                                        .setToogleText()
                                }.onChange(of: settingsViewModel.limit30, perform:  { _ in
                                    if settingsViewModel.limit30 {
                                        settingsViewModel.inputTimer(.sixty)
                                        settingsViewModel.gameLimit = 30
                                        timerViewModel.timeValue = settingsViewModel.gameLimit
                                        settingsViewModel.limit5 = false
                                        settingsViewModel.limit60 = false
                                    }
                                })
                                .background(settingsViewModel.limit30 ? Color.appPurple : .clear)
                                .toggleStyle(.button)
                                
                                Toggle(isOn: $settingsViewModel.limit60) {
                                    Text("60 sec")
                                        .setToogleText()
                                }.onChange(of: settingsViewModel.limit60, perform: { _ in
                                    if settingsViewModel.limit60 {
                                        settingsViewModel.inputTimer(.oneHundredTwenty)
                                        settingsViewModel.gameLimit = 60
                                        timerViewModel.timeValue = settingsViewModel.gameLimit
                                        settingsViewModel.limit30 = false
                                        settingsViewModel.limit5 = false
                                    }
                                })
                                .background(settingsViewModel.limit60 ? Color.appPurple : .clear)
                                .toggleStyle(.button)
                                .padding(.bottom, 25)
                                
                            }
                        } label: {
                            HStack {
                                Text("Duration")
                                    .font(.system(size: 20).bold())
                                    .tint(Color.black)
                                    .padding(.leading,20)
                                    .frame(height: 61)
                                Spacer()
                                Text(checkDuration(limits: settingsViewModel.limit5, settingsViewModel.limit30, settingsViewModel.limit60) ? "\(String(settingsViewModel.gameLimit)) sec" : " ")
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
                Toggle(isOn: $settingsViewModel.isOnMusic.animation(.bouncy)) {
                    Text("Music")
                        .font(.system(size: 20).bold())
                }
                .tint(Color.appBlue)
                .padding(20)
            }.frame(width:308, height: 69)
                .padding(.bottom,20)
            
            
            if settingsViewModel.isOnMusic {
                ZStack() {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(Color.appLightBlue)
                        .frame(width: 308)
                    
                    VStack() {
                        DisclosureGroup( isExpanded: $gameMusicStandBy) {
                            VStack( spacing: 0) {
                                
                                Divider()
                                    .background(Color.appBlue)
                                
                                Toggle(isOn: $settingsViewModel.classicMusic) {
                                    Text("Classical")
                                        .padding(.trailing,190)
                                        .font(.system(size: 20))
                                        .frame(width:282, height: 40)
                                        .tint(.black)
                                } .onChange(of: settingsViewModel.classicMusic,perform:  { _ in
                                    if settingsViewModel.classicMusic {
                                        settingsViewModel.currentMusic = "Classical"
                                        settingsViewModel.instrumentalMusic = false
                                        settingsViewModel.natureMusic = false
                                    }
                                })
                                .background(settingsViewModel.classicMusic ? Color.appPurple : .clear)
                                .toggleStyle(.button)
                                
                                Toggle(isOn: $settingsViewModel.instrumentalMusic) {
                                    Text("Instrumentals")
                                        .padding(.trailing,150)
                                        .font(.system(size: 20))
                                        .frame(width:282, height: 40)
                                        .tint(.black)
                                }.onChange(of: settingsViewModel.instrumentalMusic, perform:  { _ in
                                    if settingsViewModel.instrumentalMusic {
                                        settingsViewModel.currentMusic = "Instrumentals"
                                        settingsViewModel.classicMusic = false
                                        settingsViewModel.natureMusic = false
                                    }
                                })
                                .background(settingsViewModel.instrumentalMusic ? Color.appPurple : .clear)
                                .toggleStyle(.button)
                                
                                Toggle(isOn: $settingsViewModel.natureMusic) {
                                    Text("Nature")
                                        .setToogleText()
                                }.onChange(of: settingsViewModel.natureMusic, perform: { _ in
                                    if settingsViewModel.natureMusic {
                                        settingsViewModel.currentMusic = "Nature"
                                        settingsViewModel.classicMusic = false
                                        settingsViewModel.instrumentalMusic = false
                                    }
                                })
                                .background(settingsViewModel.natureMusic ? Color.appPurple : .clear)
                                .toggleStyle(.button)
                                .padding(.bottom, 25)
                                
                            }
                        } label: {
                            HStack {
                                Text("Select Music")
                                    .font(.system(size: 20).bold())
                                    .tint(Color.black)
                                    .padding()
                                    .frame(height: 61)
                                Spacer()
                                Text(checkMusic(musics: settingsViewModel.classicMusic, settingsViewModel.instrumentalMusic, settingsViewModel.natureMusic)  ? (settingsViewModel.currentMusic ?? "") : "")
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
                    ZStack {
                        PickShape(playerIcons: icons[number])
                        Button(action: {
                                settingsViewModel.currentSkin = number
                                saveSkins(
                                    firstSkin: icons[number].first,
                                    secondSkin: icons[number].last
                                )
                        } ) {
                            ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 112, height: 39)
                                .foregroundStyle(fetchSelectedSkinsIndex() == number ? Color.appBlue : Color.appLightBlue)
                            Text( fetchSelectedSkinsIndex() == number ? "Picked" : "Choose")
                                .tint(fetchSelectedSkinsIndex() == number ? Color.white : Constants.Colors.black)
                                .font(.system(size: 16).bold())
                        }
                            
                        }.padding(.top,70)
                        .shadow(color: Color(red: 0.6, green: 0.62, blue: 0.76).opacity(0.1), radius: 15, x: 4, y: 4)
                    }
                }
            }
        }
        .frame(width: 324, height: 490)
        .padding(.top,40)
        .padding(.bottom, 123)
        
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
            settingsViewModel.saveSkinsIntoUD(skin1: firstSkin, skin2: secondSkin)
        }
    }
    
    private func fetchSelectedSkinsIndex() -> Int {
        guard let index = settingsViewModel.currentSkin else {
            return 0
        }
        return index
    }
}

#Preview {
    SettingsGameView()
        .environmentObject(SettingsViewModel())
        .environmentObject(TimerViewModel())
        .environmentObject(AudioService())
}
