//
//  PreviewView.swift
//  Story Wizard
//
//  Created by jack rathbone on 21/10/2022.
//

import SwiftUI

struct PreviewView: View {
    @EnvironmentObject var profile: Profile
    @Binding var page : Page
    var body: some View {
            ZStack {
                Color.black.ignoresSafeArea().opacity(0.8)
                PreviewOverlay(page: $page)
                    .padding()
            }
    }
}
struct PreviewOverlay: View {
    @EnvironmentObject var profile: Profile
    @Binding var page: Page
    var body: some View {
        if profile.currentBookIndex != -1 {
            GeometryReader {g in
                ZStack {
                    Color.white
                        .cornerRadius(10, corners: [.topRight, .bottomRight])
                        .offset(CGSize(width: 0, height: g.size.height * 0.1))
                        
                    profile.libraryRender[profile.currentBookIndex].frontCover
                        .resizable()
                        .aspectRatio(CGSize(width: g.size.width, height: g.size.height * 0.8),contentMode: .fit)
                        .opacity(0.7)
                    
                        .cornerRadius(10, corners: [.topRight, .bottomRight])
                        .offset(CGSize(width: 0, height: g.size.height * 0.1))
                    PreviewData(page: $page)
                        .offset(CGSize(width: 0, height: g.size.height * 0.1))
                    
                }
                .frame(width: g.size.width, height: g.size.height * 0.8)
                
            }
        }
    }
}

struct PreviewData: View {
    @EnvironmentObject var profile: Profile
    @State var showRating: Bool = true
    @Binding var page: Page
    var body: some View {
        if profile.currentBookIndex != -1 {
            GeometryReader {g in
                VStack(alignment: .center) {
                    HStack {
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                profile.currentBookIndex = -1
                            }
                        }, label: {
                            Image(systemName: "x.square")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                        })
                        Spacer()
                        OutlinedText(text: profile.libraryRender[profile.currentBookIndex].title, width: 1, color: .white)
                            .font(Font.customHeader(size: 25))
                        
                        Spacer()
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                profile.removeBook(id: profile.libraryRender[profile.currentBookIndex].id)
                                profile.currentBookIndex = -1
                            }
                        }, label: {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                        })
                    }
                    
                    Spacer()
                    OutlinedText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi volutpat sollicitudin ligula, ac molestie turpis lacinia posuere.", width: 1, color: .white)
                        .font(Font.customHeader(size: 20))
                        
                    Spacer()
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            page = .readStory
                        }, label: {
                            VStack {
                                Image(systemName: "book")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    
                                OutlinedText(text: "Read", width: 1, color: .white)
                                    .font(Font.customHeader(size: 15))
                                    .foregroundColor(.black)
                            }
                            .foregroundColor(.black)
                        })
                        
                        Spacer()
                        Button(action: {
                            profile.bookmark(id: profile.libraryRender[profile.currentBookIndex].id)
                        }, label: {
                            VStack {
                                if profile.libraryRender[profile.currentBookIndex].bookmarked {
                                    Image(systemName: "bookmark.fill")
                                        .resizable()
                                        .frame(width: 50, height: 60)
                                        .foregroundColor(.red)
                                } else {
                                    Image(systemName: "bookmark")
                                        .resizable()
                                        .frame(width: 50, height: 60)
                                        .foregroundColor(.black)
                                }
                                
                                OutlinedText(text: "Bookmark", width: 1, color: .white)
                                    .font(Font.customHeader(size: 15))
                                    .foregroundColor(.black)
                            }
                        })
                        Spacer()
                    }
                    Spacer()
                    
                    
                }
                .padding()
            }
        }
    }
}


struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(page: .constant(Page.library))
            .environmentObject(TestData.testProfileWithSelectedBook)
        
    }
        
}
