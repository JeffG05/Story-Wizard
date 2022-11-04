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
                HStack {
                    VStack {
                        Text("Please rate this story")
                            .font(Font.customHeader(size: 25))
                            .foregroundColor(.mainYellow)
                            .padding()
                        Divider()
                        Text("Your feedback will be used to improve future stories")
                            .font(Font.customHeader(size: 20))
                            .foregroundColor(.mainYellow)
                            .multilineTextAlignment(.center)
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                currentRating = .LIKE
                                withAnimation(.linear(duration: 0.5)) {
                                    showReason = false
                                }                        }, label: {
                                    VStack {
                                        Image(currentRating == .LIKE ? "happyFace.fill" : "happyFace")
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
                                    Image(currentRating == .DISLIKE ? "sadFace.fill" : "sadFace")
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
                                    FeedbackButton(text: "Too Long")
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
                        
                            
                            Button(action: {
                                page = .library
                            }, label: {
                                HStack {
                                    Spacer()
                                    Text("Skip")
                                    
                                        .padding()
                                        .font(Font.customHeader(size: 15))
                                    Spacer()
                                }
                                .background() {
                                    Color.mainYellow
                                }
                            })
                            
                        
                        
                        
                        
                    }
                    .background() {
                        Color.mainBlue
                    }
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
                .padding()
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
                .frame(width: UIScreen.main.bounds.width/3.2)
                .frame(height: UIScreen.main.bounds.height/12)
                .padding()
            }.overlay(
                RoundedRectangle(cornerRadius: 15).stroke(Color(.black), lineWidth: 2))
                    .background() {
                if clicked {
                    Color.mainYellow
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
