//
//  ThanksFeedbackPage.swift
//  Story Wizard
//
//  Created by jack rathbone on 28/10/2022.
//

import SwiftUI

struct ThanksFeedbackPage: View {
    @Binding var page: Page
    var background: Image
    var body: some View {
        GeometryReader {g in
        ZStack {
            background
                .resizable()
                .aspectRatio(CGSize(width: g.size.width, height: g.size.height), contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.3)
            VStack(alignment: .center) {
                Text("Thanks for the feedback")
                    .font(Font.customHeader(size: 25))
                Text("Your input will be used to help us make more amazing stories for you")
                    .font(Font.customHeader(size: 20))
                    .multilineTextAlignment(.center)
            }
        }
        .onAppear(perform :{
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut(duration: 0.25)) {
                    page = .library
                }
            }
        })
    }
        
    }
}

struct ThanksFeedbackPage_Previews: PreviewProvider {
    static var previews: some View {
        ThanksFeedbackPage(page: .constant(.rating), background: Image("IslandOfParadiseCover"))
    }
}
