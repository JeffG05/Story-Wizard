//
//  ChooseUserPage.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct ChooseUserPage: View {
    @Binding var user: User
    @Binding var page: Page
    var proxy: GeometryProxy
    
    var body: some View {
        VStack {
            HeaderView(
                text: "Who's Reading?"
            )
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 0) {
                    ForEach(user.profiles, id: \.self) { profile in
                        ProfileOptionView(profile: profile, proxy: proxy) {
                            selectProfile(profile: profile)
                        }
                    }
                }
                .padding(.horizontal, proxy.size.width / 12)
            }
        }
        .frame(width: proxy.size.width, height: proxy.size.height)
    }
    
    func selectProfile(profile: Profile) {
        user.currentProfile = profile
        page = .home
    }
}

struct ProfileOptionView: View {
    var profile: Profile
    var proxy: GeometryProxy
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                profile.profileCircle(size: proxy.size.width / 3)
                Text(profile.name)
                    .font(CustomFont.mainBody.font)
            }
        }
        .foregroundColor(.black)
        .padding(.vertical)
    }
}

struct ChooseUserPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            ChooseUserPage(user: .constant(TestData.testUser), page: .constant(.chooseUser), proxy: g)
        }
    }
}
