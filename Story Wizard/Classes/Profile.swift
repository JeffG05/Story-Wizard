//
//  Profile.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct Profile: Hashable {
    var name: String
    var profilePicture: Image
    var library: [Book] // library array stores book objects
    
    init(name: String, profilePicture: Image) {
        self.name = name
        self.profilePicture = profilePicture
        self.library = [] // initialise empty library on profile creation
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
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.name == rhs.name && lhs.profilePicture == rhs.profilePicture
    }
}

struct ProfileCircle_Previews: PreviewProvider {
    static var previews: some View {
        TestData.testProfile.profileCircle()
    }
}
