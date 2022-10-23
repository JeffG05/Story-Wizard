//
//  NavigationView.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct NavigationView: View {
    @State private var page: Page = .signIn
    @State private var user: User = TestData.testUser
    
    @State private var prevPage: Page = .signIn
    @State private var currentPage: Page = .signIn
        
    var body: some View {
        GeometryReader { g in
            switch page {
            case .signIn:
                SignInPage(page: $page, proxy: g)
            case .signUp:
                SignUpPage(page: $page, proxy: g)
            case .chooseUser:
                ChooseUserPage(user: $user, page: $page, proxy: g)
            case .home:
                HomePage(profile: user.currentProfile!, page: $page, proxy: g)
            case .createStory:
                CreateStoryPage(page: $page, proxy: g)
            case .readStory:
                ReadStoryPage(page: $page, proxy: g)
            case .library:
                LibraryPage(profile: user.currentProfile!, page: $page, proxy: g)
            case .settings:
                SettingsPage(user: $user, page: $page, proxy: g)
            default:
                EmptyView()
            }
        }
        .onChange(of: page) { _ in
            if page == .goBack {
                currentPage = prevPage
                page = currentPage
            }
            
            if page != currentPage {
                prevPage = currentPage
                currentPage = page
            }            
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
