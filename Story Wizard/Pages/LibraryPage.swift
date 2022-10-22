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
        let shelfboardHeight: CGFloat = 25
        let shelves = max(Int(ceil(Double(profile.library.count) / 2.0) * 2), 6)
        
        VStack {
            HeaderView(
                text: "\(profile.name)'s Library",
                profile: profile,
                rightIcon: "gear",
                profileAction: goToUserSwitcher,
                rightAction: goToSettings
            )
            
            GeometryReader { g in
                let shelfSectionHeight = (g.size.height - proxy.safeAreaInsets.bottom) / 3
                ScrollView(showsIndicators: false) {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 0),
                            GridItem(.flexible(), spacing: 0)
                        ],
                        spacing: 0
                    ) {
                        ForEach(0..<shelves, id: \.self) { i in
                            VStack(spacing: 0) {
                                Shelf(proxy: g, height: shelfboardHeight)
                                HStack(spacing: 0) {
                                    if i % 2 == 0 {
                                        Image("Wood")
                                            .resizable()
                                            .frame(width: shelfboardHeight)
                                    }
                                    if i < profile.library.count {
                                        BookOptionView(book: profile.library[i], maxWidth: (g.size.width/2)-shelfboardHeight, maxHeight: shelfSectionHeight - shelfboardHeight) {}
                                    } else {
                                        Spacer()
                                    }
                                    if i % 2 == 1 {
                                        Image("Wood")
                                            .resizable()
                                            .frame(width: shelfboardHeight)
                                    }
                                }
                                .background(
                                    Image(decorative: UIImage(named: "Wood")!.cgImage!, scale: 1, orientation: .left)
                                        .resizable()
                                        .brightness(-0.2)
                                )
                            }
                            .frame(width: g.size.width / 2, height: shelfSectionHeight)
                        }
                        Shelf(proxy: proxy, height: proxy.safeAreaInsets.bottom)
                        Shelf(proxy: proxy, height: proxy.safeAreaInsets.bottom)
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear {
                print(proxy.safeAreaInsets.bottom)
            }
        }
    }
    
    func goToUserSwitcher() {
        page = .chooseUser
    }
    
    func goToSettings() {
        page = .settings
    }
}

struct Shelf: View {
    var proxy: GeometryProxy
    var height: CGFloat
    
    var body: some View {
        Image(decorative: UIImage(named: "Wood")!.cgImage!, scale: 1, orientation: .left)
            .resizable()
            .frame(width: proxy.size.width / 2, height: height)
    }
}

struct BookOptionView: View {
    var book: Book
    var maxWidth: CGFloat
    var maxHeight: CGFloat
    var action: () -> Void
    
    var body: some View {
        
        let bookHeight = maxHeight - 20
        let bookWidth = bookHeight * (2/3)
        
        ZStack {
            Button {
                action()
            } label: {
                ZStack {
                    book.bookCover(size: bookHeight)
                    Text(book.title)
                        .frame(width: bookWidth)
                        .font(Font.customBody())
                        .foregroundColor(.white)
                        .bold()
                }
                .frame(width: bookWidth, height: bookHeight)
            }
            .foregroundColor(.black)
            .padding(.top, 20)
        }
        .frame(width: maxWidth, height: maxHeight)
    }
}

struct LibraryPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            LibraryPage(profile: TestData.testProfile, page: .constant(.library), proxy: g)
        }
    }
}
