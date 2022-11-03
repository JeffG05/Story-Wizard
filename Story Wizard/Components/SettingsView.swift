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
                     .cornerRadius(10, corners: [.topRight, .bottomRight])
                     .offset(CGSize(width: 0, height: g.size.height * 0.1))
                     .overlay() {
                         BackgroundStarsView()
                             .frame(width: g.size.width, height: g.size.height * 0.8)
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
                HStack {
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            showSettings = false
                        }
                    }, label: {
                        Image(systemName: "x.square")
                            .resizable()
                            .frame(width: 30, height: 30)
                    })
                    
                    profile.profileCircle(size: g.size.width / 5)
                    HeaderView(text:"\(profile.name)'s Settings")
                }
                .foregroundColor(.black)
                
                VStack {
                    HStack {
                        Text("Reading Age (Years)")
                            
                        Button("-", action:{
                            profile.decrementReadingAge()
                        })
                        Text("\(profile.readingAge)")
                        Button("+", action:{
                            profile.incrementReadingAge()
                        })

                        Spacer()
                    }.font(Font.customHeader(size:20))
                    
                    VStack {
                        HStack {
                            Text("Text Size:")
                                .padding()
                                .font(Font.customHeader(size:20))
                            Spacer()
                        }
                        HStack {
                            ForEach(0..<fontSizeOptions.count, id: \.self) {optionIndex in
                                Button(action: {
                                    profile.textSize = fontSizeOptions[optionIndex].fontValue
                                }, label: {
                                    Text(fontSizeOptions[optionIndex].label)
                                        .font(Font.customHeader(size: CGFloat(fontSizeOptions[optionIndex].size)))
                                        .padding()
                                        .background() {
                                            if profile.textSize == fontSizeOptions[optionIndex].fontValue {
                                                Color.gray
                                            }
                                        }
                                        .cornerRadius(15)
                                            
                                        
                                })
                            }
                        }
                            

                        Spacer()
                    }
                }
                Spacer()
                
                
            }
            .padding()
            .foregroundColor(.mainYellow)
        }
    }
}

struct FontSizeOption {
    var label: String
    var fontValue: TextSize
    var size: Int
}
