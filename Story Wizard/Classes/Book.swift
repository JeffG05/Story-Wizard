//
//  Book.swift
//  Story Wizard
//
//  Created by Jordan Saphir on 22/10/2022.
//

import SwiftUI


struct Book: Hashable, Identifiable {
    
    var id: UUID
    var title: String
    var frontCover: Image
    var blurb: String
    var bookmarked: Bool
    var themes: [String]
    var pages: [String]
    var rating: Rating
    init(title: String, frontCover: Image, blurb: String,bookmarked: Bool, themes: [String]) {
        self.id = UUID()
        self.title = title
        self.frontCover = frontCover
        self.blurb = blurb
        self.bookmarked = bookmarked
        self.themes = themes
        self.pages = ["One day there was a tropical island, it was very tropical",
                      "On the island was a tree called kenny. Kenny was a very big tree and his favourite sports was surfing",
                      "One day there was a storm and it was so windy that Kenny snapped in half and died"]
        self.rating = .NONE
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
    mutating func rate(rating: Rating) {
        self.rating = rating
    }
    
}
