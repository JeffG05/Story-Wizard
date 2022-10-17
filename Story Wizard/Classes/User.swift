//
//  User.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

class User {
    
    var name: String
    var email: String
    var password: String
    var profiles: [Profile]
    var currentProfile: Profile?
    
    init(name: String, email: String, password: String, profiles: [Profile], currentProfile: Profile? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.profiles = profiles
        self.currentProfile = currentProfile ?? profiles.first
    }
    
}
