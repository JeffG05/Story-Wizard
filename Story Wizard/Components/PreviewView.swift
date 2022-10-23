//
//  PreviewView.swift
//  Story Wizard
//
//  Created by jack rathbone on 21/10/2022.
//

import SwiftUI

struct PreviewView: View {
    @Binding var showPreview: Bool
    var bookIndex: Int
    @EnvironmentObject var user: User
    var body: some View {
            ZStack {
                Color.black.ignoresSafeArea().opacity(0.8)
                PreviewOverlay(showPreview: $showPreview, bookIndex: bookIndex)
                    .padding()
                    .shadow(radius: 10)
            }
    }
}
struct PreviewOverlay: View {
    @Binding var showPreview: Bool
    var bookIndex: Int
    @EnvironmentObject var user: User
    var body: some View {
         GeometryReader {g in
             ZStack {
                 user.profiles[user.currentProfileIndex].library[bookIndex].frontCover
                     .resizable()
                     .aspectRatio(CGSize(width: g.size.width, height: g.size.height * 0.8),contentMode: .fit)
                     
                     .cornerRadius(10, corners: [.topRight, .bottomRight])
                     .offset(CGSize(width: 0, height: g.size.height * 0.1))
                 PreviewData(showPreview: $showPreview, bookIndex: bookIndex)
                     .offset(CGSize(width: 0, height: g.size.height * 0.1))
                     
             }
             .frame(width: g.size.width, height: g.size.height * 0.8)
                        
            }
    }
}

struct PreviewData: View {
    @Binding var showPreview: Bool
    var bookIndex: Int
    @EnvironmentObject var user: User
    var body: some View {
        GeometryReader {g in
            VStack(alignment: .center) {
                HStack {
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            showPreview = false
                        }
                    }, label: {
                        Image(systemName: "x.square")
                            .resizable()
                            .frame(width: 40, height: 40)
                    })
                    Spacer()
                    Text(user.profiles[user.currentProfileIndex].library[bookIndex].title)
                        .font(Font.customHeader(size: 25))
                        
                    Spacer()
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            showPreview = false
                        }
                    }, label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 40, height: 40)
                    })
                }
                
                .foregroundColor(.white)
                Spacer()
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi volutpat sollicitudin ligula, ac molestie turpis lacinia posuere. Nunc vitae lorem non felis varius tincidunt. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean at sapien ut justo tincidunt eleifend. Mauris dictum urna sit amet velit semper tincidunt.")
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Spacer()
                        Button(action: {}, label: {
                            VStack {
                                Image(systemName: "book")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Text("Read")
                                    .font(Font.customHeader(size: 15))
                            }
                        })
                    
                    Spacer()
                    Button(action: {
                        user.profiles[user.currentProfileIndex].library[bookIndex].bookmark()
                    }, label: {
                        VStack {
                            if user.profiles[user.currentProfileIndex].library[bookIndex].bookmarked {
                                Image(systemName: "bookmark.fill")
                                    .resizable()
                                    .frame(width: 50, height: 60)
                                    .foregroundColor(.red)
                            } else {
                                Image(systemName: "bookmark")
                                    .resizable()
                                    .frame(width: 50, height: 60)
                            }
                            
                            Text("Bookmark")
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
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(showPreview: .constant(true), bookIndex: 0)
            .environmentObject(TestData.testUser)
        
    }
}
