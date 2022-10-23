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
    @Published var profiles: [Profile]
    @Published var currentProfileIndex: Int = -1
    
    init(name: String, email: String, password: String, profiles: [Profile], currentProfileIndex: Int = 0) {
        self.name = name
        self.email = email
        self.password = password
        self.profiles = profiles
        self.currentProfileIndex = currentProfileIndex
    }
    
}
