//
//  SettingsPage.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct SettingsPage: View {
    @EnvironmentObject var user: User
    @Binding var page: Page
    var proxy: GeometryProxy
    
    var body: some View {
        VStack {
            HeaderView(
                text: "Settings",
                leftIcon: "arrow.left",
                leftAction: goBack
            )
            Spacer()
        }
    }
    
    func goBack() {
        page = .goBack
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            SettingsPage(page: .constant(.settings), proxy: g)
                .environmentObject(TestData.testUser)
        }
        .environmentObject(TestData.testUser)
    }
}
