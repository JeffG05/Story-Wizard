//
//  Profile.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

class Profile: Hashable {
    var name: String
    var profilePicture: Image
    
    init(name: String, profilePicture: Image) {
        self.name = name
        self.profilePicture = profilePicture
    }
    
    func profileCircle(size: CGFloat = 42) -> some View {
        profilePicture
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
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
