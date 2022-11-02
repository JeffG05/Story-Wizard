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
                    .shadow(radius: 10)
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
                     .foregroundColor(.white)
                     .aspectRatio(CGSize(width: g.size.width, height: g.size.height * 0.8),contentMode: .fit)
                     .cornerRadius(10, corners: [.topRight, .bottomRight])
                     .offset(CGSize(width: 0, height: g.size.height * 0.1))
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
                    }
                    
                    HStack {
                        Text("Text Size")
                        Button("Aa", action:{
                            profile.textSize = .small
                        })
                        .font(Font.customHeader(size: 15))
                        
                        Button("Aa", action:{
                            profile.textSize = .medium
                        })
                        .font(Font.customHeader(size: 25))
                        
                        Button("Aa", action:{
                            profile.textSize = .large
                        })
                        .font(Font.customHeader(size: 45))
                            

                        Spacer()
                    }
                }
                Spacer()
                
                
            }
            .padding()
        }
    }
}
