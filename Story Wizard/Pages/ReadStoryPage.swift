//
//  ReadStoryPage.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI
import AVFoundation

struct ReadStoryPage: View {
    @Binding var page: Page

    @State var currentPage: Int = 0
    @State var offsetPage: CGFloat = 0
    @State var useSpeech: Bool = false
    var proxy: GeometryProxy
    @StateObject var profile: Profile
    
    var body: some View {
        ZStack {
            if currentPage == 0 || currentPage ==  profile.libraryRender[profile.currentBookIndex].pages.count + 1{
                profile.libraryRender[profile.currentBookIndex].frontCover
                               .resizable()
                               .aspectRatio(CGSize(width: proxy.size.width, height: proxy.size.height), contentMode: .fill)
                               .ignoresSafeArea()
                               .opacity(0.3)
                               
            } else {
                Color.white
            }
            GeometryReader {g in
                VStack(alignment: .leading) {
                    if currentPage > 0 && currentPage < profile.libraryRender[profile.currentBookIndex].pages.count + 1 {
                        
                        HeaderView(
                            leftIcon: "x.square",
                            rightIcon: "gear",
                            middleIcon: useSpeech ? "speaker.wave.2.fill" : "speaker.wave.2",
                            leftAction: goBack,
                            rightAction: settings,
                            middleAction: toggleSpeech
                        )
                    } else {
                        HeaderView(
                            leftIcon: "x.square",
                            rightIcon: "gear",
                            leftAction: goBack,
                            rightAction: settings
                        )
                    }
                    TabView(selection: $currentPage) {
                        VStack {
                            Text(profile.libraryRender[profile.currentBookIndex].title)
                                .font(Font.customHeader(size: 30))
                                .multilineTextAlignment(.center)
                                .padding(15)
                            Text("Swipe to read")
                        }.tag(0)
                        ForEach(0..<profile.libraryRender[profile.currentBookIndex].pages.count, id: \.self) {index in
                            VStack {
                                Spacer()
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed libero mi. In eu tellus ac justo malesuada blandit elementum non risus. Vivamus nec congue velit.")
                                    .font(Font.customHeader(size: 25))
                                    .multilineTextAlignment(.center)
                                    .padding(15)
                                Spacer()
                            }
                            .frame(width:g.size.width)
                            .tag(index + 1)
                        }
                        VStack {
                            Text("The end")
                                .font(Font.customHeader(size: 25))
                                .multilineTextAlignment(.center)
                                .padding(15)
                            Text("Swipe to go back")
                        }
                        .tag(profile.libraryRender[profile.currentBookIndex].pages.count + 1)
                        .frame(width:g.size.width)
                        Text("")
                            .tag(profile.libraryRender[profile.currentBookIndex].pages.count + 2)
                        
                    }.indexViewStyle(.page(backgroundDisplayMode: .interactive))
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .onChange(of: currentPage) {newValue in
                            if newValue > profile.libraryRender[profile.currentBookIndex].pages.count + 1 {
                                if profile.libraryRender[profile.currentBookIndex].rating == .NONE {
                                    page = .rating
                                } else {
                                    page = .library
                                }
                            }
                        }
                    HStack {
                        Spacer()
                        Text("Page \(currentPage + 1)")
                    }
                    .padding()
                }
                
                
            }
            
        }.animation(.easeInOut, value: currentPage)
    }
    func toggleSpeech() {
        useSpeech = !useSpeech
        if useSpeech {
            readPageOutLoud()
        }
    }
    func readPageOutLoud() {
        let utterance = AVSpeechUtterance(string: profile.libraryRender[profile.currentBookIndex].pages[currentPage-1])
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.pitchMultiplier = 1.0
        utterance.rate = 0.3
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func goBack() {
        page = .goBack
    }
    func settings() {
        page = .settings
    }
}

struct ReadStoryPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            ReadStoryPage(page: .constant(.readStory), proxy: g, profile: TestData.testProfileWithSelectedBook)
        }
    }
}
