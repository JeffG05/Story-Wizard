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
    var body: some View {
        GeometryReader {g in
            ZStack {
                profile.libraryRender[profile.currentBookIndex].frontCover
                    .resizable()
                    .aspectRatio(CGSize(width: g.size.width, height: g.size.height), contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(0.3)
                VStack {
                    Spacer()
                    Text("Please rate this story")
                        .font(Font.customHeader(size: 25))
                    HStack {
                        Spacer()
                        Button(action: {
                            currentRating = .LIKE
                        }, label: {
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
                    Spacer()
                    if currentRating != .NONE {
                        Button(action: {
                            profile.rateBook(id: profile.libraryRender[profile.currentBookIndex].id, rating: currentRating)
                            page = .library
                        }, label: {
                            Image(systemName: "arrow.right.circle")
                                .resizable()
                                .frame(width: 60, height: 60)
                        })
                    }
                    Spacer()
                    
                    
                }
                .foregroundColor(.black)
            }
        }
        
    }
}

struct RatingPage_Previews: PreviewProvider {
    static var previews: some View {
        RatingPage(page: .constant(.rating), profile: TestData.testProfileWithSelectedBook)
    }
}
