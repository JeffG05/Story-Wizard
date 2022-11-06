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
    var proxy: GeometryProxy
    
    private let pages: [SlidePage] = SlidePage.samplePages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        ZStack {
            Color.mainBlue
                .ignoresSafeArea()
            
            BackgroundStarsView()
                .frame(width: proxy.size.width, height: proxy.size.height)
            
            VStack {
                Spacer()
                Image("FullWizzo")
                    .resizable()
                    .frame(width: proxy.size.width, height: proxy.size.width)
                .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                .offset(y: proxy.size.width / 5)
                
            }
            
            VStack {
                TabView(selection: $pageIndex) {
                    ForEach(pages) { page in
                        WalkthroughView(
                            page: page,
                            buttonText: page == pages.last ? "Done!" : "Next",
                            buttonAction: page == pages.last ? goToSignUp : incrementPage,
                            skipAction: goToSignUp
                        )
                            .tag(page.tag)
                    }
                }
                .animation(.easeInOut, value: pageIndex)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .tabViewStyle(PageTabViewStyle())
                .onAppear {
                    dotAppearance.currentPageIndicatorTintColor = UIColor(Color.mainYellow)
                    dotAppearance.pageIndicatorTintColor = .gray
                }
                .padding(.bottom, 8)
            }
            .ignoresSafeArea()
            
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
    var buttonText: String
    var buttonAction: () -> Void
    var skipAction: () -> Void
    
    var body: some View {
        GeometryReader { g in
            VStack(spacing: 10) {
                HeaderView(
                    text: page.name
                )
                .foregroundColor(.mainYellow)
                
                
                HStack(spacing:16){
                    Image("\(page.image)")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                        .padding(.vertical)
                    
                    Text(page.description)
                        .font(Font.customHeader(size:20))
                        .frame(width: g.size.width / 2)
                        .foregroundColor(.mainYellow)
                        .multilineTextAlignment(.center)
                    
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button {
                    buttonAction()
                } label: {
                    Text(buttonText)
                        .font(.customHeader(size: 20))
                        .foregroundColor(.black)
                        .padding(.vertical, 4)
                        .frame(width: g.size.width * 0.66)
                }
                .background(Color.mainYellow)
                .cornerRadius(10, corners: .allCorners)
                .padding(.top)
                
                Button {
                    skipAction()
                } label: {
                    Text("Skip")
                        .font(.customHeader(size: 14))
                        .foregroundColor(.mainYellow)
                        .bold()
                        .padding(.vertical, 2)
                        .padding(.horizontal)
                }
                .padding(.bottom, 4)
                .disabled(buttonText.contains("Done"))
                .opacity(buttonText.contains("Done") ? 0 : 1)
                
            }
            .frame(height: g.size.height - 16)
//            .background(.red)
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
        SlidePage(name: "HOME", description: "This is the home page. Here you can create a story or go to your library.", image: "Home", tag: 0),
        SlidePage(name: "CREATE STORY", description: "Select an option for your story. If you don't like the options, click shuffle and new options will appear!", image: "CreateStory", tag: 1),
        SlidePage(name: "LIBRARY", description: "Here is where you store your books. Click one of the buttons to turn on a filter and click again to turn it off. Click on a book to see a preview. Click read to enjoy your story!", image: "Library", tag: 2),
        SlidePage(name: "READ", description: "Swipe to flip the page. You can bookmark your favourite books or press the audio button to have the book read to you.", image: "Reading", tag: 3),
        SlidePage(name: "FEEDBACK", description: "At the end of the book, make sure to rate the book with a face to help Wizzo write your books.", image: "Feedback", tag: 4),

    ]
}


struct WalkthroughPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            WalkthroughPage(page: .constant(.walkthrough), proxy: g)
        }
        .environmentObject(TestData.testUser)
    }
}
