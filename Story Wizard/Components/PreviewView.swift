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
    @Binding var degree : Double
    var body: some View {
            ZStack {
                PreviewOverlay(page: $page)
                    .padding()
                    .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
            }
            .zIndex(100)
            .foregroundColor(.mainYellow)
    }
}
struct PreviewOverlay: View {
    @EnvironmentObject var profile: Profile
    @Binding var page: Page
    var body: some View {
        if profile.currentBookIndex != -1 {
            GeometryReader {g in
                ZStack {
                    Color.mainBlue
                        .cornerRadius(10, corners: [.topRight, .bottomRight])
                        .offset(CGSize(width: 0, height: g.size.height * 0.1))
                    Image("Stars")
                        .resizable()
                        .opacity(0.3)
                        .aspectRatio(contentMode: .fit)
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
                        Text(profile.libraryRender[profile.currentBookIndex].title)
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
                    HStack {
                        if profile.libraryRender[profile.currentBookIndex].rating == .LIKE {
                            Image("happyFace")
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                        }
                        if profile.libraryRender[profile.currentBookIndex].rating == .DISLIKE {
                            Image("sadFace")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        Spacer()
                    }
                    Text(profile.libraryRender[profile.currentBookIndex].blurb)
                        .font(Font.customHeader(size: 20))
                        .multilineTextAlignment(.center)
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
                                    .foregroundColor(.black)
                                    
                                Text("Read")
                                    .font(Font.customHeader(size: 15))
                            }
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
                                
                                Text("Bookmark")
                                    .font(Font.customHeader(size: 15))
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
        PreviewView(page: .constant(Page.library), degree: .constant(0))
            .environmentObject(TestData.testProfileWithSelectedBook)
        
    }
        
}
