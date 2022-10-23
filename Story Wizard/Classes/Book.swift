//
//  Book.swift
//  Story Wizard
//
//  Created by Jordan Saphir on 22/10/2022.
//

import SwiftUI


struct Book: Hashable {
    
    var title: String
    var frontCover: Image
    var blurb: String
    var bookmarked: Bool
    var themes: [String]
    init(title: String, frontCover: Image, blurb: String,bookmarked: Bool, themes: [String]) {
        self.title = title
        self.frontCover = frontCover
        self.blurb = blurb
        self.bookmarked = bookmarked
        self.themes = themes
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
    mutating func bookmark() {
        self.bookmarked = !self.bookmarked
    }
    
}
