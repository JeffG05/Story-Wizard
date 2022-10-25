//
//  Profile.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct Profile: Hashable, Identifiable {
    var id: UUID
    var name: String
    var profilePicture: Image?
    var profileColor: Color
    var library: [Book] // library array stores book objects
    
    init(name: String, profilePicture: Image? = nil, profileColor: Color) {
        self.id = UUID()
        self.name = name
        self.profilePicture = profilePicture
        self.profileColor = profileColor
        self.library = [] // initialise empty library on profile creation
    }
    
    @MainActor
    static func defaultProfilePicture(color: Color) -> Image {
        ZStack {
            Image("Headshot")
                .opacity(0.3)
        }
        .background(color)
        .generateSnapshot()
    }
    
    static var profileColorOptions: [Color] {
        return [
            .blue,
            .red,
            .pink,
            .purple,
            .green,
            .cyan,
            .orange,
            .mint,
            .indigo
        ]
    }
    
    @MainActor
    func profileCircle(size: CGFloat = 42) -> some View {
        
        (profilePicture ?? Profile.defaultProfilePicture(color: profileColor))
            .resizable()
            .scaledToFill()
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

extension View {
    @MainActor
    func generateSnapshot() -> Image {
        let renderer = ImageRenderer(content: self)
        return Image(uiImage: renderer.uiImage ?? UIImage())
    }
}

struct ProfileCircle_Previews: PreviewProvider {
    static var previews: some View {
        TestData.testProfile.profileCircle()
    }
}
