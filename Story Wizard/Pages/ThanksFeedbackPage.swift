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
            Color.mainBlue.ignoresSafeArea()
            VStack(alignment: .center) {
                Image("FullWizzo")
                    .resizable()
                    .aspectRatio(CGSize(width: 20, height: 20),contentMode: .fit)
                Spacer()
                Text("Thank You!")
                    .font(Font.customHeader(size: 25))
                Text("Wizzo will use your feedback to create even better stories in future")
                    .font(Font.customHeader(size: 20))
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
            .foregroundColor(.mainYellow)
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
