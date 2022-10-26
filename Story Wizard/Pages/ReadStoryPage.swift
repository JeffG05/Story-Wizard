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
    @EnvironmentObject var user: User
    var proxy: GeometryProxy
    
    var body: some View {
        ZStack {
            user.profiles[user.currentProfileIndex].library[user.profiles[user.currentProfileIndex].currentBookIndex].frontCover
                .resizable()
                .aspectRatio(CGSize(width: proxy.size.width, height: proxy.size.height), contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.3)
            GeometryReader {g in
                VStack(alignment: .leading) {
                    if currentPage > 0 && currentPage < user.profiles[user.currentProfileIndex].library[user.profiles[user.currentProfileIndex].currentBookIndex].pages.count + 1 {
                        HeaderView(
                            leftIcon: "x.square",
                            rightIcon: "gear",
                            middleIcon: "speaker.wave.2",
                            leftAction: goBack,
                            rightAction: settings,
                            middleAction: readPageOutLoud
                        )
                    } else {
                        HeaderView(
                            leftIcon: "x.square",
                            rightIcon: "gear",
                            leftAction: goBack,
                            rightAction: settings
                        )
                    }
                    
                    HStack(alignment: .center) {
                        VStack {
                            Text(user.profiles[user.currentProfileIndex].library[user.profiles[user.currentProfileIndex].currentBookIndex].title)
                                .font(Font.customHeader(size: 25))
                                .multilineTextAlignment(.center)
                                .padding(15)
                            Text("Swipe to read")
                        }
                            .frame(width:g.size.width)
                        ForEach(0..<user.profiles[user.currentProfileIndex].library[user.profiles[user.currentProfileIndex].currentBookIndex].pages.count, id: \.self) {index in
                            VStack {
                                Spacer()
                                Text(user.profiles[user.currentProfileIndex].library[user.profiles[user.currentProfileIndex].currentBookIndex].pages[index])
                                    .font(Font.customHeader(size: 25))
                                    .multilineTextAlignment(.center)
                                    .padding(15)
                                Spacer()
                            }
                                .frame(width:g.size.width)
                        }
                        VStack {
                            Text("The end")
                                .font(Font.customHeader(size: 25))
                                .multilineTextAlignment(.center)
                                .padding(15)
                            Text("Swipe to go back")
                        }
                        .frame(width:g.size.width)
                        
                        
                    
                }
                .offset(x: CGFloat(offsetPage))
                
                Spacer()
                
                }
                
            }
            
        }.gesture(DragGesture(minimumDistance: 3, coordinateSpace: .local)
            .onChanged({value in
                offsetPage = CGFloat(-400 * currentPage) + value.translation.width
            })
            .onEnded({ value in
                if value.translation.width < 0 {
                    // left
                    withAnimation(Animation.linear(duration: 0.25)) {
                        if currentPage < user.profiles[user.currentProfileIndex].library[user.profiles[user.currentProfileIndex].currentBookIndex].pages.count + 1 {
                            currentPage += 1
                            offsetPage = CGFloat(-400 * currentPage)
                        } else {
                            page = .goBack
                        }
                        
                        
                    }
                }

                if value.translation.width > 0 {
                    // right
                    withAnimation(Animation.linear(duration: 0.25)) {
                        if currentPage > 0 {
                            currentPage -= 1
                            
                        }
                        offsetPage = CGFloat(-400 * currentPage)
                        
                    }
                }
            }))
    }
    func readPageOutLoud() {
        let utterance = AVSpeechUtterance(string: user.profiles[user.currentProfileIndex].library[user.profiles[user.currentProfileIndex].currentBookIndex].pages[currentPage-1])
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
            ReadStoryPage(page: .constant(.readStory), proxy: g)
        }
        .environmentObject(TestData.testUser)
    }
}
