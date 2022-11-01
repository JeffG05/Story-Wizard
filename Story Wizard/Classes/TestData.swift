//
//  TestData.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

//["One day there was a tropical island, it was very tropical",
//              "On the island was a tree called kenny. Kenny was a very big tree and his favourite sports was surfing",
//              "One day there was a storm and it was so windy that Kenny snapped in half and died"]

import SwiftUI

class TestData {
    // Books
//    static var testBook: Book = Book(title: "Lost in Paradise", frontCover: Image("IslandOfParadiseCover"), blurb: "Editor placeholder in source file", bookmarked: true, themes: ["Tropical"])
//
//    static var testBook2: Book = Book(title: "Lost2", frontCover: Image("LostInParadise"), blurb: "Editor placeholder in source file", bookmarked: false, themes: ["Tropical"])
//
//    static var testBook3: Book = Book(title: "Lost3", frontCover: Image("LostInParadise"), blurb: "Editor placeholder in source file", bookmarked: false, themes: ["Tropical"])
    
    static var testBook: Book = Book.random(title: "Book 1")
    
    static var testBook2: Book = Book.random(title: "Book 2")
    
    static var testBook3: Book = Book.random(title: "Book 3")
    
    // Profiles
    static var testProfile: Profile {
        let profile = Profile(name: "Profile 1", profileColor: Profile.profileColorOptions[0])
        profile.addBook(bookObj: testBook)
        profile.addBook(bookObj: testBook2)
        profile.addBook(bookObj: testBook3)
        
        return profile
    }
    static var testProfileWithSelectedBook: Profile {
        let profile = Profile(name: "Profile 9", profileColor: Profile.profileColorOptions[0])
        profile.addBook(bookObj: testBook)
        profile.addBook(bookObj: testBook2)
        profile.addBook(bookObj: testBook3)
        profile.currentBookIndex = 0
        return profile
    }
    static var testProfile2: Profile {
        let profile = Profile(name: "Profile 2", profileColor: Profile.profileColorOptions[2])
        profile.addBook(bookObj: testBook3)
        return profile
    }
    static var testProfile3: Profile {
        let profile = Profile(name: "Profile 3", profileColor: Profile.profileColorOptions[3])
        profile.addBook(bookObj: testBook)
        profile.addBook(bookObj: testBook2)
        return profile
    }
    
    // Users
    static var testUser: User = User(name: "Adult", email: "test@gmail.com", password: "password", numberPin: "1234", profiles: [testProfile, testProfile2, testProfile3])
}
