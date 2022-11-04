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
    @State var word: String = ""
    @State var theme: String = ""
    
    var body: some View {
        Color.mainBlue
            .ignoresSafeArea()
        
        BackgroundStarsView()
        ScrollView {
            VStack {
                HeaderView(
                    text: "Settings",
                    leftIcon: "arrow.left",
                    leftAction: goBack
                )
                
                Text("Banned Words")
                    .font(.headline)
                    .frame(maxWidth: proxy.size.width / 1.2, alignment: .leading)
                
                BannedWordsView(proxy: proxy, lst: user.bannedWords)
                
                HStack {
                    TextField("Input word", text: $word)
                        .padding()
                        .frame(width: proxy.size.width / 1.5)
                        .background(Color.starBlue)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Button("Submit", action: {
                        let trimmed = word.trimmingCharacters(in: .whitespacesAndNewlines) // remove whitespace from name
                        if (trimmed.count != 0) {
                            user.addBannedWord(word: word)
                            word = ""
                        }

                    })
                    .foregroundColor(Color.mainYellow)
                }
                
                Text("Banned Themes")
                    .font(.headline)
                    .frame(maxWidth: proxy.size.width / 1.2, alignment: .leading)
                
                BannedWordsView(proxy: proxy, lst: user.bannedThemes)
                
                HStack {
                    TextField("Input theme", text: $theme)
                        .padding()
                        .frame(width: proxy.size.width / 1.5)
                        .background(Color.starBlue)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Button("Submit", action: {
                        let trimmed = theme.trimmingCharacters(in: .whitespacesAndNewlines) // remove whitespace from theme
                        if (trimmed.count != 0) {
                            user.addBannedTheme(word: theme)
                            theme = ""
                        }
                    })
                    .foregroundColor(Color.mainYellow)
                }

                
                Button("Click here to read more about our AI", action: {
                    disclaimer()
                })
                .foregroundColor(Color.mainYellow)
                .frame(maxWidth: proxy.size.width / 1.2, alignment: .leading)
                
                SignInButton(proxy: proxy, text:"Sign Out"){
                    signout()
                }
                
                
                .foregroundColor(Color.mainYellow)
                .padding()
            }
        }
    }
    
    func goBack() {
        page = .goBack
    }
    
    func disclaimer() {
        page = .disclaimer
    }
    
    
    func signout() {
        page = .signIn // also probs have to change environment variable user.
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

struct BannedWordsView: View {
    @EnvironmentObject var user: User
    var proxy: GeometryProxy
    var lst: [String]

    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<lst.count, id: \.self) { i in
                    Text(lst[i])
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
        .frame(maxWidth: proxy.size.width / 1.2, maxHeight: 300)

        .background(Rectangle().fill(Color.mainYellow).shadow(radius: 3))
    }
}
