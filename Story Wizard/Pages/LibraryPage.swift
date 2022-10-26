//
//  LibraryPage.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct LibraryPage: View {
    @State var showSettings: Bool = false
    @Binding var page: Page
    var proxy: GeometryProxy
    @StateObject var profile: Profile
    var body: some View {
        
        ZStack {
            BackgroundBubbleView(bubblePosition: .left, proxy: proxy)
            
            VStack {
                HeaderView(
                    text: "\(profile.name)'s Library",
                    leftIcon: "arrow.backward",
                    rightIcon: "gear",
                    leftAction: goToHome,
                    rightAction: goToSettings
                )
                
                Button("Alphabetical", action:{
                    profile.filterType = .alphabetical
                    profile.sort_library()
                })
                
                Button("Rev-Alphabetical", action:{
                    profile.filterType = .rev_alphabet
                    profile.sort_library()
                })
                
                Button("Date Added", action:{
                    profile.filterType = .date_added
                    profile.sort_library()
                })
                
                Button("Bookmarked", action:{
                    profile.filterType = .bookmarked
                    profile.sort_library()
                })
                
                Bookcase(proxy: proxy)
            }
            if profile.currentBookIndex != -1 {
                PreviewView(page: $page)
            }
            if showSettings == true {
                SettingsView(showSettings: $showSettings)
            }
        }
        .environmentObject(profile)
    }
    
    func goToHome() {
        page = .home
    }
    
    func goToSettings() {
        showSettings = true
        
//        page = .settings
    }
}

struct Bookcase: View {
    @EnvironmentObject var profile: Profile
    var proxy: GeometryProxy
    var body: some View {
        let shelfboardHeight: CGFloat = 25
        let shelves = max(Int(ceil(Double(profile.libraryRender.count) / 2.0) * 2), 6)
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
    
                                if i < profile.libraryRender.count {
                                   BookOptionView(book: profile.libraryRender[i], maxWidth: (g.size.width/2)-shelfboardHeight, maxHeight: shelfSectionHeight - shelfboardHeight, thisIndex: i) {}
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
    @EnvironmentObject var profile: Profile
    var book: Book
    var maxWidth: CGFloat
    var maxHeight: CGFloat
    var thisIndex: Int
    var action: () -> Void
    var body: some View {
        
        let bookHeight = maxHeight - 20
        let bookWidth = bookHeight * (2/3)
        
        ZStack {
            Button {
            action: do {
                withAnimation(.easeIn(duration: 0.25)) {
                    profile.setCurrentBook(index: thisIndex)
                }
            }
            } label: {
                ZStack {
                    book.bookCover(size: bookHeight)
                    
                    OutlinedText(text: book.title, width: 1.5, color: .black)
                        .font(Font.customHeader(size: 20))
                        .frame(width: bookWidth)
                        .foregroundColor(.white)
                        .bold()
                    
                    if thisIndex < profile.libraryRender.count && profile.libraryRender[thisIndex].bookmarked {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(.red)
                            .offset(x: bookWidth * 0.3, y: -1 * bookHeight * 0.45)
                    }
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
            LibraryPage( page: .constant(.library), proxy: g, profile:TestData.testUser.profiles[0])
        }
        .environmentObject(TestData.testUser)
    }
}
