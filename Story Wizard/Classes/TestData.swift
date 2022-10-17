//
//  TestData.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

class TestData {
    
    static var testProfile: Profile = Profile(name: "Child 1", profilePicture: Image("ProfileImage"))
    static var testProfile2: Profile = Profile(name: "Child 2", profilePicture: Image("ProfileImage2"))
    static var testProfile3: Profile = Profile(name: "Child 3", profilePicture: Image("ProfileImage3"))
    static var testUser: User = User(name: "Adult", email: "test@gmail.com", password: "password", profiles: [testProfile, testProfile2, testProfile3])
}
