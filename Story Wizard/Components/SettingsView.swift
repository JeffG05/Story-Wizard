//
//  SettingsView.swift
//  Story Wizard
//
//  Created by Jordan Saphir on 25/10/2022.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettings: Bool
    @EnvironmentObject var profile: Profile
    var proxy: GeometryProxy
    
    var body: some View {
            ZStack {
                Color.black.ignoresSafeArea().opacity(0.8)
                SettingsOverlay(showSettings: $showSettings, proxy: proxy) // added proxy call
                    .padding()
                    
            }
            .zIndex(100)
    }
}


struct SettingsOverlay: View {
    @Binding var showSettings: Bool
    @EnvironmentObject var profile: Profile
    var proxy: GeometryProxy
    
    var body: some View {
         GeometryReader {g in
             ZStack {
                 Rectangle()
                     .foregroundColor(.mainBlue)
                     .aspectRatio(CGSize(width: g.size.width, height: g.size.height * 0.8),contentMode: .fit)
                     .cornerRadius(10, corners: .allCorners)
                     .offset(CGSize(width: 0, height: g.size.height * 0.1))
                     .overlay() {
                         BackgroundStarsView()
                             .frame(width: g.size.width, height: g.size.height * 0.8)
                             .cornerRadius(10, corners: .allCorners)
                             .offset(CGSize(width: 0, height: g.size.height * 0.1))
                     }
                 SettingsData(showSettings: $showSettings, proxy: proxy)
                     .offset(CGSize(width: 0, height: g.size.height * 0.1))
                     

             }
             .frame(width: g.size.width, height: g.size.height * 0.8)
                        
            }
    }
}



struct SettingsData: View {
    @Binding var showSettings: Bool
    @EnvironmentObject var profile: Profile
    
    let fontSizeOptions: [FontSizeOption] = [FontSizeOption(label: "Aa", fontValue: .small, size: 15),FontSizeOption(label: "Aa", fontValue: .medium, size: 25),FontSizeOption(label: "Aa", fontValue: .large, size: 45)]
    var proxy: GeometryProxy // have to define proxy for user circle
    var body: some View {
        GeometryReader {g in
            VStack(alignment: .center) {
                HStack(alignment: .center){
                    profile.profileCircle(size: 40)
                    Spacer()
                    
                    Text("\(profile.name)")
                        .font(Font.customHeader(size:30))
                        //.foregroundColor(Color.mainYellow)
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            showSettings = false
                        }
                    }, label: {
                        Image("exit")
                            .resizable()
                            .frame(width: 30, height: 30)
        
                    })
                }
                .foregroundColor(.mainYellow)
                .padding(.bottom)
                
                VStack(spacing: 50) {
                    HStack {
                        Text("Reading Age:")
                            .font(Font.customHeader(size: 22))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        HStack {
                            Button("-", action:{
                                profile.decrementReadingAge()
                            })
                            .padding(.horizontal)
                            Text("\(profile.readingAge)")
                            Button("+", action:{
                                profile.incrementReadingAge()
                            })
                            .padding(.horizontal)
                        }.font(Font.customHeader(size: CGFloat(fontSizeOptions[1].size)))
                    }
                    
                    HStack {
                        Text("Text Size:")
                            .font(Font.customHeader(size:22))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        HStack {
                            ForEach(0..<fontSizeOptions.count, id: \.self) {optionIndex in
                                Button(action: {
                                    profile.textSize = fontSizeOptions[optionIndex].fontValue
                                }, label: {
                                    Text(fontSizeOptions[optionIndex].label)
                                        .font(Font.customHeader(size: CGFloat(fontSizeOptions[optionIndex].size)))
                                        .padding(.vertical, 4)
                                        .frame(width: proxy.size.width / 6, height: CGFloat(fontSizeOptions[fontSizeOptions.count-1].size) + 32)
                                        .background() {
                                            if profile.textSize == fontSizeOptions[optionIndex].fontValue {
                                                Color.gray
                                            }
                                        }
                                        .cornerRadius(15)
                                    
                                    
                                })
                            }
                        }
                    }
                    
                    HStack (alignment: .center) {
                        Toggle("Dyslexic Mode:", isOn: $profile.dyslexicMode)
                            .font(Font.customHeader(size:22))
                            .tint(Color.mainYellow)
                    }
                }
                Spacer()
            
            }
            .padding()
            .padding(.horizontal, 8)
            .foregroundColor(.mainYellow)
        }
    }
}

struct FontSizeOption {
    var label: String
    var fontValue: TextSize
    var size: Int
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            SettingsView(showSettings: .constant(true), proxy: g)
                .environmentObject(TestData.testProfileWithSelectedBook)
        }
    }
        
}
