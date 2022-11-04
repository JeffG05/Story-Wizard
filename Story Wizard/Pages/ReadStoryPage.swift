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
    @State var showSettings: Bool = false

    @State var currentPage: Int = 0
    @State var offsetPage: CGFloat = 0
    @State var useSpeech: Bool = false
    var proxy: GeometryProxy
    @StateObject var profile: Profile
    @State var voice: AVSpeechSynthesisVoice? = nil
    
    let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        ZStack {
            if currentPage == 0 || currentPage ==  profile.libraryRender[profile.currentBookIndex].pages.count + 1 {
                profile.libraryRender[profile.currentBookIndex].frontCover
                               .resizable()
                               .aspectRatio(CGSize(width: proxy.size.width, height: proxy.size.height), contentMode: .fill)
                               .ignoresSafeArea()
                               .opacity(0.3)
                               
            } else {
                Color.white
            }
            GeometryReader {g in
                ZStack {
                    VStack {
                        if currentPage > 0 && currentPage < profile.libraryRender[profile.currentBookIndex].pages.count + 1 && profile.libraryRender[profile.currentBookIndex].pageImages[currentPage - 1] != "" {
                            Image(profile.libraryRender[profile.currentBookIndex].pageImages[currentPage - 1])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: g.size.width, height: g.size.height / 2)
                                .ignoresSafeArea()
                            Spacer()
                        }
                    }
                    VStack(alignment: .leading) {
                        if currentPage > 0 && currentPage < profile.libraryRender[profile.currentBookIndex].pages.count + 1 {
                            
                            HeaderView(
                                leftIcon: "x.square",
                                rightIcon: "gear",
                                middleIcon: useSpeech ? "speaker.wave.2.fill" : "speaker.wave.2",
                                middleDisabled: true,
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
                                        .font(Font.customHeader(size: profile.convertFontSize()))
                                        .multilineTextAlignment(.center)
                                        .padding(15)
                                    Text("Swipe to read")
                                }.tag(0)
                                ForEach(0..<profile.libraryRender[profile.currentBookIndex].pages.count, id: \.self) {index in
                                    VStack {
                                        Spacer()
                                        
                                            VStack {
                                                
                                                Spacer()
                                                
                                                Text(profile.libraryRender[profile.currentBookIndex].pages[index])
                                                    .font(Font.customHeader(size: profile.convertFontSize()))
                                                
                                                    .multilineTextAlignment(.center)
                                                    .padding(15)
                                                
                                                
                                                if profile.libraryRender[profile.currentBookIndex].pageImages[index] == "" {
                                                    Spacer()
                                                }
                                            }
                                            .frame(width:g.size.width, height: profile.libraryRender[profile.currentBookIndex].pageImages[index] != "" ? CGFloat(g.size.height / 2) : CGFloat(g.size.height))
                                        
                                    }.tag(index + 1)
                                    
                                }
                            
                            VStack {
                                Text("The end")
                                    .font(Font.customHeader(size: profile.convertFontSize()))
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
                                
                                if useSpeech {
                                    readPageOutLoud()
                                }
                            }
                        HStack {
                            Spacer()
                            Text("Page \(currentPage + 1)")
                        }
                        .padding()
                    }
                }
                
                
            }
            
            if showSettings == true {
                SettingsView(showSettings: $showSettings, proxy: proxy)
                    .environmentObject(profile)
            }
            
        }
        .animation(.easeInOut, value: currentPage)
        .onAppear {
            findVoice()
        }
    }
    
    func toggleSpeech() {
        useSpeech = !useSpeech
        if useSpeech {
            readPageOutLoud()
        }
    }
    
    func findVoice() {
        if let v = AVSpeechSynthesisVoice(language: "en-GB") {
            voice = v
        } else if let v = AVSpeechSynthesisVoice(language: "English") {
            voice = v
        } else {
            voice = nil
        }
    }
    
    func readPageOutLoud() {
        let pages = profile.libraryRender[profile.currentBookIndex].pages
        if pages.indices.contains(currentPage-1) {
            let text = pages[currentPage-1]
            
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = voice
            utterance.pitchMultiplier = 1.2
            utterance.rate = 0.3
            
            synthesizer.stopSpeaking(at: .immediate)
            synthesizer.speak(utterance)
        }
    }
    
    func goBack() {
        page = .goBack
    }
    func settings() {
//        page = .settings
        showSettings = true

    }
}

struct ReadStoryPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            ReadStoryPage(page: .constant(.readStory), proxy: g, profile: TestData.testProfileWithSelectedBook)
        }
    }
}
