//
//  HomePage.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var user: User
    @State var showSettings: Bool = false
    @Binding var page: Page
    var proxy: GeometryProxy
    
    var body: some View {
        ZStack {
            BackgroundStarsView()
            
            VStack {
                HeaderView(
                    text: "Welcome\n\(user.currentProfile!.name)!",
                    showProfile: true,
                    rightIcon: Image("gear"),
                    profileAction: goToUserSwitcher,
                    rightAction: goToSettings
                )
                .foregroundColor(.mainYellow)
                HomePageButton(text: "Create A Story", image: Image("HomePageImage1"), yOffset: 75, proxy: proxy) {
                    goToStoryCreator()
                }
                Spacer()
                HomePageButton(text: "See Your Stories", image: Image("HomePageImage2"), yOffset: 100, proxy: proxy) {
                    goToLibrary()
                }
                Spacer()
            }
            .padding(.bottom, proxy.size.height / 8)
        }
        if showSettings == true {
            SettingsView(showSettings: $showSettings, proxy: proxy)
                .environmentObject(user.currentProfile!)
        }
    }
    
    func goToUserSwitcher() {
        page = .chooseUser
    }
    
    func goToSettings() {
        showSettings = true
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
    var image: Image
    var yOffset: CGFloat
    var proxy: GeometryProxy
    var action: () -> Void
    
    var body: some View {
        ZStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 7 * proxy.size.width / 8)
            
            Button {
                action()
            } label: {
                Text(text)
                    .font(Font.customHeader(size: 25))
                    .frame(width: 2 * proxy.size.width / 3)
                    .padding(.vertical, 24)
            }
            .background(
                RoundedRectangle(cornerRadius: 36)
                    .fill(Color.mainYellow)
                    .shadow(color: .black.opacity(0.25), radius: 2, y: 4)
            )
            .foregroundColor(Color.black)
            .transformEffect(.init(translationX: 0, y: yOffset))
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            HomePage(page: .constant(.home), proxy: g)
        }
        .environmentObject(TestData.testUser)
    }
}
