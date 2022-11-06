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
    
    static var randomTitles: [String] = ["Adventures in Paradise","Danger on the moon","Poker in the pyramids","A wonderful story","Guinness book of world records"]
    
    static var randomName: [String] = ["Jack","Jordan","Jacob", "Chris","Robbie","Jeff","Guy","Dan","Martian"]
    
    static var fakeGeneratedBook2 : Book = Book(title: "The lonely robot", frontCover: Image("lonelyRobotCover"), blurb: "A lone robot goes looking for friends in the town", bookmarked: false, pages: ["One day there was a robot called Chris, he was lonely."
                                                                                                                                                                                                         ,"One day he went looking for friends in the local town."
                                                                                                                                                                                                         ,"All of the other children were scared of the robot because he was made of metal. They ran away from the robot, which made him sad."
                                                                                                                                                                                                         ,"But then the robot stumbled onto some other children playing football, they asked him to join."
                                                                                                                                                                                                         ,"The robot was great at football because of his metal legs",
                                                                                                                                                                                                         "The other kids loved him and they became friends forever."], images: ["","town","","","",""], options: GenerationOptions(
        theme: ChoiceOption.themes.randomElement()!,
        setting: ChoiceOption.settings.randomElement()!,
        character: ChoiceOption.characters.randomElement()!,
        friend: ChoiceOption.characters.randomElement()!,
        bookTitle: "The lonely robot"
    ))
    
    static var testBook: Book = Book.random(title: "Book 1")
    
    static var testBook2: Book = Book.random(title: "Book 2")
    
    static var testBook3: Book = Book.random(title: "Book 3")
    
    static var fakeGeneratedBook1: Book = Book(
        title: "Visit to Earth",
        frontCover: Image("FakeGeneratedBookCover1"),
        blurb: "Martian the alien and his dog, Ketchup, visits the friendly dragon of the forest",
        bookmarked: false,
        pages: [
            "Martian was a green alien from space. He had a pet dog called Ketchup.",
            "Martian was walking in the forest with Ketchup when he sees a sleeping dragon",
            "When Martian got close the dragon woke up. Oh no!",
            "The dragon stood up and blew fire out of his nose and opened his mouth to speak.",
            "'Hello, I am the friendly dragon of the forest' it said.",
            "After that day, the dragon became Martian and Ketchup's best friend."
        ],
        images: [
            "FakeGeneratedBookImage1",
            "",
            "",
            "FakeGeneratedBookImage2",
            "",
            ""
        ],
        options: GenerationOptions(
            theme: ChoiceOption.themes.first(where: { $0.title == "Dragons" })!,
            setting: ChoiceOption.settings.first(where: { $0.title == "Forest" })!,
            character: ChoiceOption.characters.first(where: { $0.title == "An Alien" })!,
            friend: ChoiceOption.characters.first(where: { $0.title == "A Dog" })!,
            bookTitle: "Visit to Earth",
            characterName: "Martian",
            friendName: "Ketchup"
        )
    )
    
    // Profiles
    static var testProfile: Profile {
        let profile = Profile(name: "Profile 1", profileColor: Profile.profileColorOptions[0])
        let _ = profile.addBook(bookObj: testBook)
        let _ = profile.addBook(bookObj: testBook2)
        let _ = profile.addBook(bookObj: testBook3)
        
        

        return profile
    }
    static var testProfileWithSelectedBook: Profile {
        let profile = Profile(name: "Profile 9", profileColor: Profile.profileColorOptions[0])
        let _ = profile.addBook(bookObj: fakeGeneratedBook1)
        profile.currentBookIndex = 0
        profile.rateBook(id: fakeGeneratedBook1.id, rating: .LIKE)
        return profile
    }
    static var testProfile2: Profile {
        let profile = Profile(name: "Profile 2", profileColor: Profile.profileColorOptions[2])
        let _ = profile.addBook(bookObj: testBook3)
        return profile
    }
    static var testProfile3: Profile {
        let profile = Profile(name: "Profile 3", profileColor: Profile.profileColorOptions[3])
        let _ = profile.addBook(bookObj: testBook)
        let _ = profile.addBook(bookObj: testBook2)
        return profile
    }
    
    // Users
    static var testUser: User = User(name: "Adult", email: "Test@gmail.com", password: "password", numberPin: "1234", profiles: [testProfile, testProfile2, testProfile3])
    static var testUser2: User = User(name: "Adult", email: "Test2@gmail.com", password: "password2", numberPin: "1234", profiles: [testProfile2, testProfile3])

}
