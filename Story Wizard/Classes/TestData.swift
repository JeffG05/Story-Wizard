//
//  TestData.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

class TestData {
    // Books
    static var testBook: Book = Book(title: "Lost in Paradise", frontCover: Image("LostInParadise"))
    static var testBook2: Book = Book(title: "Lost", frontCover: Image("LostInParadise"))
    static var testBook3: Book = Book(title: "Lost3", frontCover: Image("LostInParadise"))
    
    // Profiles
    static var testProfile: Profile {
        let profile = Profile(name: "Child 1", profilePicture: Image("ProfileImage"))
        profile.addBook(bookObj: testBook)
        profile.addBook(bookObj: testBook2)
        profile.addBook(bookObj: testBook3)
        profile.addBook(bookObj: testBook)
        profile.addBook(bookObj: testBook2)
        profile.addBook(bookObj: testBook3)
        profile.addBook(bookObj: testBook)
        profile.addBook(bookObj: testBook2)
        profile.addBook(bookObj: testBook3)
        return profile
    }
    static var testProfile2: Profile {
        let profile = Profile(name: "Child 2", profilePicture: Image("ProfileImage2"))
        profile.addBook(bookObj: testBook3)
        return profile
    }
    static var testProfile3: Profile {
        let profile = Profile(name: "Child 3", profilePicture: Image("ProfileImage3"))
        profile.addBook(bookObj: testBook)
        profile.addBook(bookObj: testBook2)
        return profile
    }
    
    // Users
    static var testUser: User = User(name: "Adult", email: "test@gmail.com", password: "password", profiles: [testProfile, testProfile2, testProfile3])
}
