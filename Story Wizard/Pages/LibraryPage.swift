//
//  LibraryPage.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct LibraryPage: View {
    @EnvironmentObject var user: User
    
    @State var showPreview: Bool = false
    @State var showSettings: Bool = false
    @State var currentBookIndex : Int = -1
    
    @Binding var page: Page
    var proxy: GeometryProxy
    
    var body: some View {
        
        ZStack {
            BackgroundBubbleView(bubblePosition: .left, proxy: proxy)
            
            VStack {
                HeaderView(
                    text: "\(user.currentProfile!.name)'s Library",
                    leftIcon: "arrow.backward",
                    rightIcon: "gear",
                    leftAction: goToHome,
                    rightAction: goToSettings
                )
                
                Button("Alphabetical", action:{
                    user.currentProfile!.filterType = .alphabetical
                    user.currentProfile!.sort_library()
                })
                
                Button("Rev-Alphabetical", action:{
                    user.currentProfile!.filterType = .rev_alphabet
                    user.currentProfile!.sort_library()
                })
                
                Button("Date Added", action:{
                    user.currentProfile!.filterType = .date_added
                    user.currentProfile!.sort_library()
                })
                
                Button("Bookmarked", action:{
                    user.currentProfile!.filterType = .bookmarked
                    user.currentProfile!.sort_library()
                })
                
                Bookcase(proxy: proxy, showPreview: $showPreview, currentBookIndex: $currentBookIndex)
            }
            if showPreview && currentBookIndex != -1 {
                PreviewView(showPreview: $showPreview, bookIndex: currentBookIndex)
            }
            if showSettings == true {
                SettingsView(showSettings: $showSettings)
            }
        }
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
    @EnvironmentObject var user: User
    
    var proxy: GeometryProxy
    @Binding var showPreview: Bool
    @Binding var currentBookIndex: Int
    
    var body: some View {
        let shelfboardHeight: CGFloat = 25
        let shelves = max(Int(ceil(Double(user.currentProfile!.libraryRender.count) / 2.0) * 2), 6)
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
                                if i < user.currentProfile!.libraryRender.count {
                                   BookOptionView(book: user.currentProfile!.libraryRender[i], maxWidth: (g.size.width/2)-shelfboardHeight, maxHeight: shelfSectionHeight - shelfboardHeight, showPreview: $showPreview, currentBookIndex: $currentBookIndex, thisIndex: i) {}
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
    var book: Book
    var maxWidth: CGFloat
    var maxHeight: CGFloat
    @Binding var showPreview: Bool
    @Binding var currentBookIndex: Int
    var thisIndex: Int
    var action: () -> Void
    var body: some View {
        
        let bookHeight = maxHeight - 20
        let bookWidth = bookHeight * (2/3)
        
        ZStack {
            Button {
            action: do {
                withAnimation(.easeIn(duration: 0.25)) {
                    showPreview = true
                    currentBookIndex = thisIndex
                }
            }
            } label: {
                ZStack {
                    book.bookCover(size: bookHeight)
                    
                    Text(book.title)
                        .frame(width: bookWidth)
                        .font(Font.customHeader(size: 20))
                        .foregroundColor(.white)
                        .bold()
                    
                    if book.bookmarked {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(.red)
                            .offset(x: 40, y: -75)
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
            LibraryPage( page: .constant(.library), proxy: g)
        }
        .environmentObject(TestData.testUser)
    }
}
