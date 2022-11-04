//
//  DisclaimerPage.swift
//  Story Wizard
//
//  Created by jack rathbone on 02/11/2022.
//

import SwiftUI

struct DisclaimerPage: View {
    @Binding var page: Page
    var body: some View {
        GeometryReader {g in
            ZStack {
                BackgroundStarsView()
                
                Image("FullWizzo")
                    .resizable()
                    .frame(width: 400, height: 400)
                    .rotationEffect(Angle(degrees: 180))
                    .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                    .offset(x:0, y: -400)
                VStack {
                    
                    Text("Disclaimer")
                        .foregroundColor(.mainYellow)
                        .font(Font.customHeader(size: 30))
                        .offset(x:0,y:250)
                        
                    VStack{
                        Text("Wizzo, an AI based story creator, will always try to generate the best stories for you")
                            .foregroundColor(.mainYellow)
                            .font(Font.customHeader(size: 20))
                            .multilineTextAlignment(.center)
                        
                        
                        Text("Even Wizzo makes mistakes so if you get a story that doesn't make sense or isn't fun then let Wizzo know, your feedback is very useful")
                            .foregroundColor(.mainYellow)
                            .font(Font.customHeader(size: 20))
                            .multilineTextAlignment(.center)
                    }.offset(y: 230)
                        .padding()
                    Spacer()
                    Button(action: {
                        page = .goBack
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Okay")
                                .font(Font.customHeader(size: 25))
                                
                            Spacer()
                        }
                        .padding()
                        .background() {
                            Color.mainYellow
                        }
                    }).offset(y: -55)
                }
                
            }
        }
    }
}

struct DisclaimerPage_Previews: PreviewProvider {
    static var previews: some View {
        DisclaimerPage(page: .constant(.disclaimer))
    }
}
