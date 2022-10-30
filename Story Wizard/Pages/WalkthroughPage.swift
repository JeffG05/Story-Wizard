//
//  WalkthroughPage.swift
//  Story Wizard
//
//  Created by Jacob Curtis on 27/10/2022.
//

import SwiftUI

struct WalkthroughPage: View {
    
    @State private var pageIndex = 0
    @Binding var page: Page
    
    private let pages: [SlidePage] = SlidePage.samplePages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        Color.mainBlue
            .ignoresSafeArea()
        TabView(selection: $pageIndex) {
            ForEach(pages) { page in
                VStack {
                    HeaderView(
                       // leftIcon: "arrow.backward",
                        rightIcon: "xmark",
                       // leftAction: goToSignUp,
                        rightAction: goToSignUp
                    )
                    
                    Spacer()
                    WalkthroughView(page: page)
                    if page == pages.last {
                        
                        Button("Sign up!", action: goToSignUp)
                            .buttonStyle(.bordered)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.mainYellow))
                    } else {
                        
                        Button("Next", action: incrementPage)
                            .buttonStyle(.bordered)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.mainYellow))
                        
                    }
                    Spacer()
                }
                .tag(page.tag)
            }
        }
        .animation(.easeInOut, value: pageIndex)// 2
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            dotAppearance.currentPageIndicatorTintColor = UIColor(Color.mainYellow)
            dotAppearance.pageIndicatorTintColor = .gray
        }
    }
    
    func goToSignUp(){
        page = .signUp
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    /*
    func goToZero() {
        pageIndex = 0
    }
     */
}

struct WalkthroughView: View {
    var page: SlidePage
    
    var body: some View {
        VStack(spacing: 10) {
            Image("\(page.image)")
                .resizable()
                .scaledToFit()
                .padding()
                .cornerRadius(30)
                .background(.gray.opacity(0.20))
                .cornerRadius(10)
                .padding()
            
            Text(page.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.mainYellow)
            Text(page.description)
                .font(.title2)
                .frame(width: 340)
                .foregroundColor(.mainYellow)
                .multilineTextAlignment(.center)
        }
    }
}

struct SlidePage: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var image: String
    var tag: Int
    
    static var samplePages: [SlidePage] = [
        SlidePage(name: "Home Page", description: "This is the home page. Here you can create a story or go to your library.", image: "walkthrough1", tag: 0),
        SlidePage(name: "Create a Story", description: "Select an option for your story. If you don't like the options, click shuffle and new options will appear!", image: "walkthrough2", tag: 1),
        SlidePage(name: "Library", description: "Here is where you store the books you have read. Click on a book to see a preview of it. Click read to enjoy your story!", image: "walkthrough3", tag: 2),
        SlidePage(name: "Read Page", description: "Swipe to flip the page. You can bookmark your favourite books or press the audio button to have the book read to you.", image: "walkthrough4", tag: 3),
        SlidePage(name: "Ratings", description: "At the end of the book, make sure to rate the book with a face to help Wizzo write your books.", image: "walkthrough5", tag: 4),

    ]
}


struct WalkthroughPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            WalkthroughPage(page: .constant(.walkthrough))
        }
        .environmentObject(TestData.testUser)
    }
}
