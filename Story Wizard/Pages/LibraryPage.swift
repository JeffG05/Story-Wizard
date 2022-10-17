//
//  LibraryPage.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct LibraryPage: View {
    var profile: Profile
    @Binding var page: Page
    var proxy: GeometryProxy
    
    var body: some View {
        VStack {
            HeaderView(
                text: "\(profile.name)'s Library",
                profile: profile,
                rightIcon: "gear",
                profileAction: goToUserSwitcher,
                rightAction: goToSettings
            )
            Spacer()
        }
    }
    
    func goToUserSwitcher() {
        page = .chooseUser
    }
    
    func goToSettings() {
        page = .settings
    }
}

struct LibraryPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            LibraryPage(profile: TestData.testProfile, page: .constant(.library), proxy: g)
        }
    }
}
