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
    var pages: [String]
    init(title: String, frontCover: Image, blurb: String,bookmarked: Bool, themes: [String]) {
        self.title = title
        self.frontCover = frontCover
        self.blurb = blurb
        self.bookmarked = bookmarked
        self.themes = themes
        self.pages = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec interdum arcu non orci ullamcorper tempus. Quisque mattis massa id eros rutrum faucibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.",
                      "Donec efficitur elementum scelerisque. Aliquam sit amet leo ornare, efficitur sem non, volutpat est. Praesent laoreet vitae nisi eu placerat. Integer at egestas nisl. Ut porta gravida turpis sit amet ultrices. Aliquam sodales lacus neque, et mollis ex ornare vitae. Praesent volutpat ligula non nunc blandit, sit amet pharetra erat ornare.",
                      "Curabitur semper nulla sed dui pulvinar, dapibus vehicula nunc posuere. Praesent ultrices bibendum aliquam. Cras sodales ligula turpis, ac finibus ante hendrerit ut. Morbi ac neque in turpis ullamcorper fermentum. Duis laoreet, ante nec placerat sollicitudin, nunc quam ultrices augue, sed finibus mauris lorem in dui. Proin pharetra pharetra ipsum, sed ultrices arcu auctor vel. Vestibulum non feugiat tellus. Nulla blandit luctus dolor quis convallis."]
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
