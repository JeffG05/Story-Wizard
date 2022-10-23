//
//  HomePage.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct HomePage: View {
    var profile: Profile
    @Binding var page: Page
    var proxy: GeometryProxy
    
    var body: some View {
        ZStack {
            BackgroundStarsView()
            
            VStack {
                HeaderView(
                    text: "Welcome\n\(profile.name)!",
                    profile: profile,
                    rightIcon: "gear",
                    profileAction: goToUserSwitcher,
                    rightAction: goToSettings
                )
                .foregroundColor(.mainYellow)
                Spacer()
                HomePageButton(text: "Create A Story", proxy: proxy) {
                    goToStoryCreator()
                }
                Spacer()
                HomePageButton(text: "Read Your Stories", proxy: proxy) {
                    goToLibrary()
                }
                Spacer()
            }
        }
    }
    
    func goToUserSwitcher() {
        page = .chooseUser
    }
    
    func goToSettings() {
        page = .settings
    }
    
    func goToStoryCreator() {
        page = .createStory
    }
    
    func goToLibrary() {
        page = .library
    }
}

struct HomePageButton: View {
    var text: String
    var proxy: GeometryProxy
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(Font.customBody())
        }
        .frame(width: proxy.size.width / 2)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.init(white: 0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color.black)
                )
        )
        .foregroundColor(Color.black)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            HomePage(profile: TestData.testProfile, page: .constant(.home), proxy: g)
        }
    }
}
