//
//  PreviewView.swift
//  Story Wizard
//
//  Created by jack rathbone on 21/10/2022.
//

import SwiftUI

struct PreviewView: View {
    @Binding var showPreview: Bool
    @Binding var bookIndex: Int
    @EnvironmentObject var user: User
    @Binding var page : Page
    var body: some View {
            ZStack {
                Color.black.ignoresSafeArea().opacity(0.8)
                PreviewOverlay(showPreview: $showPreview, bookIndex: $bookIndex, page: $page)
                    .padding()
            }
    }
}
struct PreviewOverlay: View {
    @Binding var showPreview: Bool
    @Binding var bookIndex: Int
    @EnvironmentObject var user: User
    @Binding var page: Page
    var body: some View {
        if user.profiles[user.currentProfileIndex].currentBookIndex != -1 {
            GeometryReader {g in
                ZStack {
                    user.profiles[user.currentProfileIndex].library[user.profiles[user.currentProfileIndex].currentBookIndex].frontCover
                        .resizable()
                        .aspectRatio(CGSize(width: g.size.width, height: g.size.height * 0.8),contentMode: .fit)
                    
                        .cornerRadius(10, corners: [.topRight, .bottomRight])
                        .offset(CGSize(width: 0, height: g.size.height * 0.1))
                    PreviewData(showPreview: $showPreview, bookIndex: $bookIndex, page: $page)
                        .offset(CGSize(width: 0, height: g.size.height * 0.1))
                    
                }
                .frame(width: g.size.width, height: g.size.height * 0.8)
                
            }
        }
    }
}

struct PreviewData: View {
    @Binding var showPreview: Bool
    @Binding var bookIndex: Int
    @EnvironmentObject var user: User
    @Binding var page: Page
    var body: some View {
        if user.profiles[user.currentProfileIndex].currentBookIndex != -1 {
            GeometryReader {g in
                VStack(alignment: .center) {
                    HStack {
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                user.profiles[user.currentProfileIndex].currentBookIndex = -1
                            }
                        }, label: {
                            Image(systemName: "x.square.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                        })
                        Spacer()
                        OutlinedText(text: user.profiles[user.currentProfileIndex].library[user.profiles[user.currentProfileIndex].currentBookIndex].title, width: 1.5, color: .black)
                            .font(Font.customHeader(size: 25))
                        
                        Spacer()
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                showPreview = false
                            }
                        }, label: {
                            Image(systemName: "trash.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                        })
                    }
                    
                    .foregroundColor(.white)
                    Spacer()
                    OutlinedText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi volutpat sollicitudin ligula, ac molestie turpis lacinia posuere. Nunc vitae lorem non felis varius tincidunt. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean at sapien ut justo tincidunt eleifend. Mauris dictum urna sit amet velit semper tincidunt.", width: 1, color: .black)
                        .foregroundColor(.white)
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
                                OutlinedText(text: "Read", width: 1.5, color: .black)
                                    .font(Font.customHeader(size: 15))
                            }
                        })
                        
                        Spacer()
                        Button(action: {
                            user.profiles[user.currentProfileIndex].library[user.profiles[user.currentProfileIndex].currentBookIndex].bookmark()
                        }, label: {
                            VStack {
                                if user.profiles[user.currentProfileIndex].library[user.profiles[user.currentProfileIndex].currentBookIndex].bookmarked {
                                    Image(systemName: "bookmark.fill")
                                        .resizable()
                                        .frame(width: 50, height: 60)
                                        .foregroundColor(.red)
                                } else {
                                    Image(systemName: "bookmark")
                                        .resizable()
                                        .frame(width: 50, height: 60)
                                }
                                
                                OutlinedText(text: "Bookmark", width: 1.5, color: .black)
                                    .font(Font.customHeader(size: 15))
                            }
                        })
                        Spacer()
                    }
                    Spacer()
                    
                    
                }
                .foregroundColor(.white)
                .padding()
            }
        }
    }
}


struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(showPreview: .constant(true), bookIndex: .constant(0), page: .constant(Page.library))
            .environmentObject(TestData.testUser)
        
    }
}
