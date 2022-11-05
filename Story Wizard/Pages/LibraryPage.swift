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
    @State var frontDegree: Double = -90
    @State var backDegree: Double = 0
    @State var selectedFilter: Int = -1
    let filters: [FilterOption] = [FilterOption(label: "A-Z", filter: .alphabetical), FilterOption(label: "Bookmarked", filter: .bookmarked), FilterOption(label: "Liked", filter: .liked)]
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
                HStack {
                    Image("filter")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Spacer()
                    ForEach(0..<filters.count, id: \.self) {filterIndex in
                        Button(action:{
                            if selectedFilter == filterIndex {
                                profile.filterType = .date_added
                                selectedFilter = -1
                            } else {
                                profile.filterType = filters[filterIndex].filter
                                selectedFilter = filterIndex
                            }
                            profile.sort_library()
                        }, label: {
                            Text(filters[filterIndex].label)
                                .padding()
                                .background() {
                                    if filterIndex == selectedFilter {
                                        Color.mainYellow
                                    } else {
                                        Color.mainBlue
                                    }
                                }
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        })
                    }
                    
                }
                .padding()
                
                Bookcase(proxy: proxy)
            }
            if profile.currentBookIndex != -1 {
                ZStack {
                    Color.black.ignoresSafeArea().opacity(0.8)
                    PreviewView(page: $page, degree: $frontDegree)
                    BookCoverView(degree: $backDegree)
                }
                .zIndex(100)
                .onAppear {
                    backDegree = 0
                    frontDegree = -90
                    withAnimation(.linear(duration: 0.4)) {
                                    backDegree = 90
                                }
                    withAnimation(.linear(duration: 0.4).delay(0.4)){
                                    frontDegree = 0
                                }
                }
                
            }
            if showSettings == true {
                SettingsView(showSettings: $showSettings, proxy: proxy)
                    .zIndex(100)
            }
        }
        .onAppear {
            selectedFilter = profile.filterType != nil ? filters.map({ return $0.filter }).firstIndex(of: profile.filterType!) ?? -1 : -1
            profile.sort_library()
        }
        .environmentObject(profile)
    }
    
    func goToHome() {
        page = .home
    }
    
    func goToSettings() {
        showSettings = true
    }
}

struct Bookcase: View {
    @EnvironmentObject var profile: Profile
    var proxy: GeometryProxy
    var body: some View {
        let shelfboardHeight: CGFloat = 10
        let shelves = max(Int(ceil(Double(profile.libraryRender.count) / 2.0) * 2), 6)
        GeometryReader { g in
            let shelfSectionHeight = (g.size.height - proxy.safeAreaInsets.bottom) / 2.5
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
                withAnimation(.easeInOut(duration: 0.25)) {
                    profile.setCurrentBook(index: thisIndex)
                }
            }
            } label: {
                ZStack {
                    book.bookCover(size: bookHeight)
                        .cornerRadius(10, corners: [.topRight, .bottomRight])
                    
                    OutlinedText(text: book.title, width: 1.5, color: .black)
                        .font(Font.customHeader(size: 20).bold())
                        .frame(width: bookWidth)
                        .foregroundColor(.white)
                    
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

struct FilterOption: Equatable {
    var label: String
    var filter: FilterType
}

struct LibraryPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            LibraryPage( page: .constant(.library), proxy: g, profile:TestData.testUser.profiles[0])
        }
        .environmentObject(TestData.testUser)
    }
}
