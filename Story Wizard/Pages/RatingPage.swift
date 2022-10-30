//
//  RatingPage.swift
//  Story Wizard
//
//  Created by jack rathbone on 27/10/2022.
//

import SwiftUI

struct RatingPage: View {
    @Binding var page: Page
    @StateObject var profile: Profile
    @State var currentRating: Rating = .NONE
    @State var dislikeReason: String = ""
    @State var showReason: Bool = false
    let columns = [GridItem(.adaptive(minimum: 180)), GridItem(.adaptive(minimum: 180))]
    var body: some View {
        GeometryReader {g in
            ZStack {
                profile.libraryRender[profile.currentBookIndex].frontCover
                    .resizable()
                    .aspectRatio(CGSize(width: g.size.width, height: g.size.height), contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(0.3)
                VStack {
                    Text("Please rate this story")
                        .font(Font.customHeader(size: 25))
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            currentRating = .LIKE
                            withAnimation(.linear(duration: 0.5)) {
                                showReason = false
                            }                        }, label: {
                            VStack {
                                Image(systemName: currentRating == .LIKE ? "hand.thumbsup.fill" : "hand.thumbsup")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Text("Like")
                            }
                        })
                        Spacer()
                        Button(action: {
                            currentRating = .DISLIKE
                            withAnimation(.linear(duration: 0.5)) {
                                showReason = true
                            }
                        }, label: {
                            VStack {
                                Image(systemName: currentRating == .DISLIKE ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Text("Dislike")
                            }
                        })
                        Spacer()

                    }
                    HStack {
                        if showReason {
                            LazyVGrid(columns: columns,alignment: .center, spacing:15) {
                                FeedbackButton(text: "Too Boring")
                                FeedbackButton(text: "Inapropriate")
                                FeedbackButton(text: "Doesn't make sense")
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    HStack {
                        if currentRating != .NONE {
                            Button(action: {
                                profile.rateBook(id: profile.libraryRender[profile.currentBookIndex].id, rating: currentRating)
                                withAnimation(.easeInOut(duration: 1)) {
                                    page = .feedbackThanks
                                }
                            }, label: {
                                Image(systemName: "arrow.right.circle")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                            })
                        }
                    }.frame(width: 60, height: 60)
                    Spacer()
                    
                    
                }
                .foregroundColor(.black)
            }
        }
        
    }
}

struct FeedbackButton : View {
    var text: String
    @State var clicked: Bool = false
    var body : some View {
        Button(action: {
            clicked = !clicked
        }, label: {
            ZStack {
                VStack {
                    Text(text)
                        .font(Font.customHeader(size: 15))
                }
                .padding()
            }.overlay(
                RoundedRectangle(cornerRadius: 15).stroke(Color(.black), lineWidth: 2))
                    .background() {
                if clicked {
                    Color.mainBlue
                        .cornerRadius(15)
                }
            }
        })
    }
}

struct RatingPage_Previews: PreviewProvider {
    static var previews: some View {
        RatingPage(page: .constant(.rating), profile: TestData.testProfileWithSelectedBook)
    }
}
