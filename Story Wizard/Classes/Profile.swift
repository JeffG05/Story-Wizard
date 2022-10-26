//
//  Profile.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

public enum FilterType: Int {
    case alphabetical  // section1 is explicitly 0. You can start at any value.
    case rev_alphabet
    case date_added
    case bookmarked
}

struct Profile: Hashable {
    var name: String
    var profilePicture: Image
    var library: [Book] // library array stores book objects
    var libraryRender: [Book]
    var filterType: FilterType?
    
    init(name: String, profilePicture: Image) {
        self.name = name
        self.profilePicture = profilePicture
        self.library = [] // stores original order of books
        self.libraryRender = [] // order of books changed depending on filter. This is what is rendered in library page
        self.filterType = .date_added
    }
    
    func profileCircle(size: CGFloat = 42) -> some View {
        profilePicture
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
    
    mutating func addBook(bookObj: Book) -> Void {
        library.append(bookObj)
        libraryRender.append(bookObj)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.name == rhs.name && lhs.profilePicture == rhs.profilePicture
    }
    
    mutating func sort_library() -> Void {
        switch filterType {
        case .alphabetical:
            libraryRender.sort{ $0.title < $1.title }
        case .rev_alphabet:
            libraryRender.sort{ $0.title > $1.title }
        case .date_added:
            libraryRender = library
        case .bookmarked:
            libraryRender = library.filter{ $0.bookmarked == true }
        case .none:
            break
        }
    }
}

struct ProfileCircle_Previews: PreviewProvider {
    static var previews: some View {
        TestData.testProfile.profileCircle()
    }
}
