//
//  BookCoverView.swift
//  Story Wizard
//
//  Created by jack rathbone on 01/11/2022.
//

import SwiftUI

struct BookCoverView: View {
    @EnvironmentObject var profile: Profile
    @Binding var degree : Double

    var body: some View {
        if profile.currentBookIndex != -1 {
            ZStack {
                GeometryReader {g in
                    ZStack {
                        profile.libraryRender[profile.currentBookIndex].frontCover
                            .resizable()
                            .aspectRatio(CGSize(width: g.size.width, height: g.size.height * 0.8),contentMode: .fit)
                            .cornerRadius(10, corners: [.topRight, .bottomRight])
                            .offset(CGSize(width: 0, height: g.size.height * 0.1))
                        OutlinedText(text: profile.libraryRender[profile.currentBookIndex].title, width: 1, color: .white)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        if profile.libraryRender[profile.currentBookIndex].bookmarked {
                            Image(systemName: "bookmark.fill")
                                .resizable()
                                .foregroundColor(.red)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .offset(x: 100, y: -160)
                        }
                    }
                    .padding()
                    .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
                    
                }
            }
        }
    }
}

struct BookCoverView_Previews: PreviewProvider {
    static var previews: some View {
        BookCoverView(degree: .constant(0))
            .environmentObject(TestData.testProfileWithSelectedBook)
    }
}
