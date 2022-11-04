//
//  NavigationView.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct NavigationView: View {

    @State private var page: Page = .walkthrough
    @State var users: [User] = [TestData.testUser, TestData.testUser2]
    @State var currentUserIndex : Int = 0
    private var pageStack: Stack = Stack<Page>()
        
    var body: some View {
        GeometryReader { g in
            switch page {
            case .walkthrough:
                WalkthroughPage(page: $page, proxy: g)
            case .signIn:
                SignInPage(page: $page, proxy: g, users: users, currentUserIndex : $currentUserIndex)
            case .signUp:
                SignUpPage(page: $page, proxy: g, userList: $users)
            case .numberPin:
                NumberPinPage(page: $page, proxy: g)
            case .numberPin2:
                NumberPinPage2(page: $page, proxy: g)
            case .chooseUser:
                ChooseUserPage(page: $page, proxy: g)
            case .home:
                HomePage(page: $page, proxy: g)
            case .createStory:
                CreateStoryPage(page: $page, proxy: g)
            case .readStory:
                ReadStoryPage(page: $page, proxy: g, profile: users[currentUserIndex].currentProfile!)
            case .library:
                LibraryPage(page: $page, proxy: g, profile: users[currentUserIndex].currentProfile!)
            case .settings:
                SettingsPage(page: $page, proxy: g)
            case .settingsPin:
                SettingsPinPage(page: $page, proxy: g)
            case .rating:
                RatingPage(page: $page, profile: users[currentUserIndex].currentProfile!)
            case .feedbackThanks:
                ThanksFeedbackPage(page: $page, background: users[currentUserIndex].currentProfile!.libraryRender[users[currentUserIndex].currentProfile!.currentBookIndex].frontCover)
            case .disclaimer:
                DisclaimerPage(page: $page)
            default:
                EmptyView()
            }
        }
        .environmentObject(users[currentUserIndex])
        .ignoresSafeArea(.keyboard)
        .onChange(of: page) { _ in
            if page == .goBack {
                let _ = pageStack.pop()
                page = pageStack.peek()!
            }
            
            if page != pageStack.peek() {
                pageStack.push(item: page)
            }
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
