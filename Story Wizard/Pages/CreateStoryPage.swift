//
//  CreateStoryPage.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct CreateStoryPage: View {
    @Binding var page: Page
    var proxy: GeometryProxy
    
    var body: some View {
        ZStack {
            BackgroundBubbleView(bubblePosition: .left, proxy: proxy)
            
            VStack {
                HeaderView(
                    text: "What will your story be about?",
                    leftIcon: "x.square",
                    leftAction: goBack
                )
                Spacer()
            }
        }
    }
    
    func goBack() {
        page = .goBack
    }
}

struct CreateStoryPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            CreateStoryPage(page: .constant(.createStory), proxy: g)
        }
        .environmentObject(TestData.testUser)
    }
}
