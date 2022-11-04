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
    
    @State var selectedWord: String? = nil
    @State var selectedTheme: String? = nil
    
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
                
                BannedWordsView(selected: $selectedWord, proxy: proxy, lst: user.bannedWords)
                
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
                
                BannedWordsView(selected: $selectedTheme, proxy: proxy, lst: user.bannedThemes)
                
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
                
                SignInButton(proxy: proxy, text:"Change/Set Pin"){
                    updatePin()
                }
                .foregroundColor(Color.mainYellow)
                .padding(.top)
                
                SignInButton(proxy: proxy, text:"Sign Out"){
                    signout()
                }
                .foregroundColor(Color.mainYellow)
                .padding(.top, 10)
                
                Button("Click here to read more about our AI", action: {
                    disclaimer()
                })
                .foregroundColor(Color.mainYellow)
                .frame(width: proxy.size.width, alignment: .center)
                .padding(.top, 12)
            }
        }
        .alert("Remove '\(selectedWord ?? "")' from banned words?", isPresented: .init(get: { return selectedWord != nil }, set: { b in selectedWord = !b ? nil : selectedWord })) {
            Button("Cancel", role: .cancel) {}
            Button("Remove", role: .destructive) {
                user.bannedWords.removeAll(where: { $0 == selectedWord })
            }
        }
        .alert("Remove '\(selectedTheme ?? "")' from banned themes?", isPresented: .init(get: { return selectedTheme != nil }, set: { b in selectedTheme = !b ? nil : selectedWord })) {
            Button("Cancel", role: .cancel) {}
            Button("Remove", role: .destructive) {
                user.bannedThemes.removeAll(where: { $0 == selectedTheme })
            }
        }
    }
    
    func goBack() {
        page = .chooseUser
    }
    
    func disclaimer() {
        page = .disclaimer
    }
    
    
    func signout() {
        page = .signIn // also probs have to change environment variable user.
    }
    
    func updatePin() {
        page = .numberPin
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
    @Binding var selected: String?
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
                        .onTapGesture {
                            selected = lst[i]
                        }
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
        .frame(maxWidth: proxy.size.width / 1.2, minHeight: 50, maxHeight: 300)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.mainYellow)
                .shadow(radius: 3)
        )
    }
}
