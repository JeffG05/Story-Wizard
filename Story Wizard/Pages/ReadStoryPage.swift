//
//  ReadStoryPage.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct ReadStoryPage: View {
    @Binding var page: Page
    var proxy: GeometryProxy
    
    var body: some View {
        VStack {
            HeaderView(
                text: "Read Story",
                leftIcon: "x.square",
                leftAction: goBack
            )
            Spacer()
        }
    }
    
    func goBack() {
        page = .goBack
    }
}

struct ReadStoryPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            ReadStoryPage(page: .constant(.readStory), proxy: g)
        }
        .environmentObject(TestData.testUser)
    }
}
