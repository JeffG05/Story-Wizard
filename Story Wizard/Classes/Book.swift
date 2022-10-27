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
    var generationOptions: GenerationOptions
    var pages: [String]
    var rating: Rating
    init(title: String, frontCover: Image, blurb: String, bookmarked: Bool, pages: [String], options: GenerationOptions) {
        self.id = UUID()
        self.title = title
        self.frontCover = frontCover
        self.blurb = blurb
        self.bookmarked = bookmarked
        self.generationOptions = options
        self.pages = pages
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
    
    static func generate(options: GenerationOptions) -> Book {
        return Book(
            title: options.bookTitle ?? "Book Title",
            frontCover: Image("LostInParadise"),
            blurb: "This is a book about \(options.theme.title.lowercased()) set in the \(options.setting.title.lowercased()). It follows the travels of \(options.character.title.lowercased())\(options.characterName == nil ? "" : " called \(options.characterName!)") and \(options.friendName == nil ? "" : "\(options.friendName!), ")\(options.friend.title.lowercased())",
            bookmarked: false,
            pages: [
                "Theme: \(options.theme.title)",
                "Setting: \(options.setting.title)",
                "Character: \(options.character.title)\(options.characterName != nil ? " (called \(options.characterName!))" : "")",
                "Friend: \(options.friend.title)\(options.characterName != nil ? " (called \(options.friendName!))" : "")"
            ],
            options: options
        )
    }
    
    static func random(title: String) -> Book {
        return Book.generate(
            options: GenerationOptions(
                theme: ChoiceOption.themes.randomElement()!,
                setting: ChoiceOption.settings.randomElement()!,
                character: ChoiceOption.characters.randomElement()!,
                friend: ChoiceOption.characters.randomElement()!,
                bookTitle: title
            )
        )
    }
    
}
