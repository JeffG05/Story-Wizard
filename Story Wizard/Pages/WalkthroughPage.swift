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
        BackgroundStarsView()
        TabView(selection: $pageIndex) {
            ForEach(pages) { page in
                VStack {
                    HStack {
                         Spacer()
                         
                        Button("Skip", action: goToSignUp)
                            .padding(.vertical, 5)
                            .foregroundColor(Color.mainYellow)
                            .fontWeight(.medium)
                            .padding(.trailing, 20)
                            .padding(.bottom, 10)
                      }
                    
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
    
    func goToChooseUser(){
        page = .chooseUser
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
            
            HeaderView(
                text: page.name
            )
            .foregroundColor(.mainYellow)
            
            HStack(spacing:10){
                Image("\(page.image)")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(25)
                    .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                    .padding()
                
                Text(page.description)
                    .font(Font.customHeader(size:20))
                    .frame(width: 150)
                    .foregroundColor(.mainYellow)
                    .multilineTextAlignment(.center)
                
            }
            
            Image("FullWizzo")
                .resizable()
                .frame(width: 180, height: 180)
                .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                //.rotationEffect(.degrees(90))
                //.transformEffect(CGAffineTransform(translationX:-( UIScreen.main.bounds.size.width/2.5), y: UIScreen.main.bounds.size.height/20))
        }
        Spacer()
    }

}

struct SlidePage: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var image: String
    var tag: Int
    
    static var samplePages: [SlidePage] = [
        SlidePage(name: "HOME", description: "This is the home page. Here you can create a story or go to your library.", image: "Home", tag: 0),
        SlidePage(name: "CREATE STORY", description: "Select an option for your story. If you don't like the options, click shuffle and new options will appear!", image: "CreateStory", tag: 1),
        SlidePage(name: "LIBRARY", description: "Here is where you store the books you have read. Click on a book to see a preview of it. Click read to enjoy your story!", image: "Library", tag: 2),
        SlidePage(name: "READ", description: "Swipe to flip the page. You can bookmark your favourite books or press the audio button to have the book read to you.", image: "Reading", tag: 3),
        SlidePage(name: "FEEDBACK", description: "At the end of the book, make sure to rate the book with a face to help Wizzo write your books.", image: "Feedback", tag: 4),

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
