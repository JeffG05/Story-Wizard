//
//  Book.swift
//  Story Wizard
//
//  Created by Jordan Saphir on 22/10/2022.
//

import SwiftUI


class Book: Hashable {
    
    var title: String
    var frontCover: Image
//    var blurb: String
    
    init(title: String, frontCover: Image) {
        self.title = title
        self.frontCover = frontCover
//        self.blurb = blurb
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title && lhs.frontCover == rhs.frontCover
    }
    
    func bookCover(size: CGFloat = 42, aspectRatio: CGFloat = 2/3) -> some View {
        frontCover
            .resizable()
            .frame(width: size * aspectRatio, height: size)
    }
    
}
