//
//  TestData.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

class TestData {
    // Books
    static var testBook: Book = Book(title: "Lost in Paradise", frontCover: Image("IslandOfParadiseCover"), blurb: "Editor placeholder in source file", bookmarked: true, themes: ["Tropical"])
    
    static var testBook2: Book = Book(title: "Lost2", frontCover: Image("LostInParadise"), blurb: "Editor placeholder in source file", bookmarked: false, themes: ["Tropical"])
    
    static var testBook3: Book = Book(title: "Lost3", frontCover: Image("LostInParadise"), blurb: "Editor placeholder in source file", bookmarked: false, themes: ["Tropical"])
    
    // Profiles
    static var testProfile: Profile {
        var profile = Profile(name: "Profile 1", profileColor: Profile.profileColorOptions[0])
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
        var profile = Profile(name: "Profile 2", profileColor: Profile.profileColorOptions[2])
        profile.addBook(bookObj: testBook3)
        return profile
    }
    static var testProfile3: Profile {
        var profile = Profile(name: "Profile 3", profileColor: Profile.profileColorOptions[3])
        profile.addBook(bookObj: testBook)
        profile.addBook(bookObj: testBook2)
        return profile
    }
    
    // Users
    static var testUser: User = User(name: "Adult", email: "test@gmail.com", password: "password", profiles: [testProfile, testProfile2, testProfile3])
}
