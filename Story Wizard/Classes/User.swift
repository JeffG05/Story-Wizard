//
//  User.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

class User : ObservableObject {
    
    var name: String
    var email: String
    var password: String
    var numberPin: String
    @Published var profiles: [Profile]
    @Published var currentProfileIndex: Int
    @Published var bannedWords: [String]
    @Published var bannedThemes: [String]
    
    
    init(name: String, email: String, password: String, numberPin: String, profiles: [Profile], currentProfileIndex: Int = 0) {
        self.name = name
        self.email = email
        self.password = password
        self.numberPin = numberPin
        self.profiles = profiles
        self.currentProfileIndex = currentProfileIndex
        self.bannedWords = ["Idiot"]
        self.bannedThemes = ["War"]
    }
    
    var currentProfile: Profile? {
        get {
            if currentProfileIndex < profiles.startIndex || currentProfileIndex >= profiles.endIndex {
                return nil
            }
            
            return profiles[currentProfileIndex]
        }
        set {
            if newValue == nil {
                return
            }
            profiles[currentProfileIndex] = newValue!
        }
    }
    
    func addBannedWord(word: String) {
        bannedWords.append(word)
    }
    
    func addBannedTheme(word: String) {
        bannedThemes.append(word)
    }
    
    
    
}
