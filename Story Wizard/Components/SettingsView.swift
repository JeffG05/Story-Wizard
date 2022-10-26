//
//  SettingsView.swift
//  Story Wizard
//
//  Created by Jordan Saphir on 25/10/2022.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettings: Bool
    
    var body: some View {
            ZStack {
                Color.black.ignoresSafeArea().opacity(0.8)
                SettingsOverlay(showSettings: $showSettings)
                    .padding()
                    .shadow(radius: 10)
            }
    }
}


struct SettingsOverlay: View {
    @Binding var showSettings: Bool

    var body: some View {
         GeometryReader {g in
             ZStack {
                 Rectangle()
                     .foregroundColor(.white)
                     .aspectRatio(CGSize(width: g.size.width, height: g.size.height * 0.8),contentMode: .fit)
                     .cornerRadius(10, corners: [.topRight, .bottomRight])
                     .offset(CGSize(width: 0, height: g.size.height * 0.1))
                 
                 SettingsData(showSettings: $showSettings)
                     .offset(CGSize(width: 0, height: g.size.height * 0.1))

             }
             .frame(width: g.size.width, height: g.size.height * 0.8)
                        
            }
    }
}



struct SettingsData: View {
    @Binding var showSettings: Bool
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
                            .frame(width: 40, height: 40)
                    })
                    
                    HeaderView(text: "Settings")
                    Spacer()
                }
                .foregroundColor(.black)
                
                VStack {
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi volutpat sollicitudin ligula, ac molestie turpis lacinia posuere. Nunc vitae lorem non felis varius tincidunt. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean at sapien ut justo tincidunt eleifend. Mauris dictum urna sit amet velit semper tincidunt.")
                    Spacer()
                    HStack {
                        Spacer()
                    }
                }
                Spacer()
                
                
            }
            .padding()
        }
    }
}
