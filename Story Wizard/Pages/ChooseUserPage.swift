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
        ZStack {
            // Background color
            Color.mainBlue
                .ignoresSafeArea()
            
            // Background star
            VStack {
                Spacer()
                Image("Star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width * 1.45)
                    .opacity(0.3)
                    .rotationEffect(.degrees(40))
            }
            .frame(width: proxy.size.width)
            
            // Main screen
            VStack {
                HeaderView(
                    text: "Who's Reading?",
                    textSize: 40
                )
                .foregroundColor(.mainYellow)
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 0) {
                        ForEach(user.profiles, id: \.self) { profile in
                            ProfileOptionView(profile: profile, proxy: proxy) {
                                selectProfile(profile: profile)
                            }
                        }
                        AddProfileView(proxy: proxy) {
                            print("Add profile")
                        }
                    }
                    .padding(.horizontal, proxy.size.width / 12)
                }
                
                Spacer()
                
                EditButton(proxy: proxy)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .ignoresSafeArea()
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
                    .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                Text(profile.name)
                    .font(Font.customBody())
                    .foregroundColor(.white)
            }
        }
        .foregroundColor(.black)
        .padding(.vertical)
    }
}

struct AddProfileView: View {
    var proxy: GeometryProxy
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.init(white: 0.85))
                        .frame(width: proxy.size.width / 3, height: proxy.size.width / 3)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width / 9)
                        .foregroundColor(Color.init(white: 0.4))
                        .fontWeight(.medium)
                }
                Text("Add Profile")
                    .font(Font.customBody())
                    .foregroundColor(.white)
            }
        }
        .foregroundColor(.black)
        .padding(.vertical)
    }
}

struct EditButton: View {
    var proxy: GeometryProxy
    
    var body: some View {
        Button {
            print("Edit")
        } label: {
            HStack {
                Image(systemName: "pencil")
                Text("Edit")
            }
            .frame(width: proxy.size.width / 2)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.init(white: 0.95))
            )
            .foregroundColor(Color.black)
            .fontWeight(.medium)
        }
    }
    
}

struct ChooseUserPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            ChooseUserPage(user: .constant(TestData.testUser), page: .constant(.chooseUser), proxy: g)
        }
    }
}
