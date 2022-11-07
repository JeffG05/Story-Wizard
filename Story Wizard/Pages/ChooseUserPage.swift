//
//  ChooseUserPage.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI
import PhotosUI

struct ChooseUserPage: View {
    @EnvironmentObject var user: User
    
    @State var editMode: Bool = false
    @State var editingProfileIndex: Int? = nil
    @State var isEditingNew: Bool = false
    
    @Binding var page: Page
    var proxy: GeometryProxy
    
    var body: some View {
        ZStack {
            // Background color
            Color.mainBlue
                .ignoresSafeArea()
            
            // Background star
            VStack {
                Spacer()
                Image("Star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width * 1.45)
                    .opacity(0.3)
                    .rotationEffect(.degrees(40))
            }
            .frame(width: proxy.size.width)
            
            // Main screen
            VStack {
                HeaderView(
                    text: "Who's Reading?",
                    textSize: 40,
                    rightIcon: Image("gear"),
                    rightAction: goToSettings
                )
                .foregroundColor(.mainYellow)
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 0) {
                        ForEach(0..<user.profiles.count, id: \.self) { i in
                            ProfileOptionView(
                                profileIndex: i,
                                editMode: $editMode,
                                proxy: proxy
                            ) {
                                if editMode {
                                    editingProfileIndex = i
                                } else {
                                    selectProfile(profileIndex: i)
                                }
                            }
                        }
                        if !editMode && editingProfileIndex == nil {
                            AddProfileView(proxy: proxy) {
                                addProfile()
                            }
                        }
                    }
                    .padding(.horizontal, proxy.size.width / 12)
                }
                
                Spacer()
                
                EditButton(editMode: $editMode, proxy: proxy)
                    .disabled(user.profiles.count == 0)
                    .opacity(user.profiles.count == 0 ? 0.5 : 1)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .ignoresSafeArea()
        .onChange(of: user.profiles.count) { count in
            if count == 0 {
                editMode = false
            }
        }
        .sheet(
            isPresented: .init(
                get: {
                    return editingProfileIndex != nil
                },
                set: { b in
                    if !b {
                        editingProfileIndex = nil
                    }
                }
            )
        ) {
            if #available(iOS 16.0, *) {
                ProfileEditSheet(activeProfile: user.profiles[editingProfileIndex!],
                                 initialName: user.profiles[editingProfileIndex!].name,
                                 initialImage: user.profiles[editingProfileIndex!].profilePicture, profileIndex: editingProfileIndex!, isNewProfile: isEditingNew) {
                    editingProfileIndex = nil
                    isEditingNew = false
                }
                .onAppear {
                    editMode = false
                }
            } else {
                // Fallback on earlier versions
                ProfileEditSheetNoPicture(activeProfile: user.profiles[editingProfileIndex!],
                                          initialName: user.profiles[editingProfileIndex!].name,
                                          initialImage: user.profiles[editingProfileIndex!].profilePicture, profileIndex: editingProfileIndex!, isNewProfile: isEditingNew) {
                    editingProfileIndex = nil
                    isEditingNew = false
                }
                .onAppear {
                    editMode = false
                }
            }
        }
    }
    
    func goToSettings() {
        page = .settingsPin
    }
    
    func selectProfile(profileIndex: Int) {
        user.currentProfileIndex = profileIndex
        page = .home
    }
    
    func addProfile() {
        var name = ""
        var color = Color.white
        
        var i = 1
        while true {
            name = "Profile \(i)"
            if user.profiles.contains(where: {
                return name == $0.name
            }) {
                i += 1
            } else {
                break
            }
        }
        
        i = 0
        var r = 0
        while true {
            color = Profile.profileColorOptions[i]
            let colorCount = user.profiles.filter { p in
                return p.profileColor == color
            }.count
            
            if colorCount <= r {
                break
            } else {
                i = (i + 1) % Profile.profileColorOptions.endIndex
                r = i == 0 ? r + 1 : r
            }
        }
        
        let newProfile = Profile(name: name, profileColor: color)
        user.profiles.append(newProfile)
        editingProfileIndex = user.profiles.endIndex - 1
        isEditingNew = true
    }
}

@available(iOS 16.0, *)
struct ProfileEditSheet: View {
    @EnvironmentObject var user: User
    @StateObject var activeProfile: Profile
    @State var initialProfile: Profile? = nil
    @State var selectedPhoto: PhotosPickerItem? = nil
    @State var isValid: Bool = true
    
    var initialName: String
    var initialImage: Image?
    
    var profileIndex: Int
    var isNewProfile: Bool
    var onDismiss: () -> Void
    
    var profile: Binding<Profile>? {
        if !user.profiles.indices.contains(profileIndex) {
            return nil
        }
        return $user.profiles[profileIndex]
    }
    
    var body: some View {
        if profile != nil {
            GeometryReader { g in
                VStack {
                    HeaderView(
                        text: isNewProfile ? "Add Profile" : "Edit Profile"
                    )
                    .foregroundColor(Color.mainYellow)
                    .padding(.bottom)
                    
                    ZStack(alignment: .topTrailing) {
                        PhotosPicker(
                            selection: $selectedPhoto,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            ZStack {
                                activeProfile
                                    .profileCircle(size: g.size.width / 3)
                                    .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                                
                                Color.black
                                    .frame(width: g.size.width / 3, height: g.size.width / 3)
                                    .clipShape(Circle())
                                    .opacity(0.2)
                                
                                Image(systemName: "pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: g.size.width / 9)
                                    .foregroundColor(.white)
                                    .fontWeight(.medium)
                            }
                            .padding(.bottom, 36)
                        }
                        
                        if profile!.wrappedValue.profilePicture != nil {
                            Button {
                                selectedPhoto = nil
                                activeProfile.profilePicture = nil
                            } label: {
                                ZStack {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                        .padding(.all, 12)
                                        .foregroundColor(.black)
                                        .bold()
                                }
                                .background(.white)
                                .clipShape(Circle())
                            }
                        }
                    }
                    TextField("Name", text: $activeProfile.name)
                        .padding()
                        .frame(width: g.size.width / 1.2)
                        .background(Color.lighterBlue)
                        .cornerRadius(5.0)
                        .multilineTextAlignment(.center)
                        .font(.customBody())
                        .onChange(of: activeProfile.name) { _ in
                            updateValidity()
                        }
                    Spacer()
                    HStack {
                        Button {
                            if isNewProfile {
                                user.profiles.remove(at: profileIndex)
                            } else {
                                activeProfile.name = initialName
                                if let newImage = initialImage {
                                    activeProfile.profilePicture = newImage
                                } else {
                                    activeProfile.profilePicture = nil
                                }
                                
                            }
                            onDismiss()
                        } label: {
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button {
                            onDismiss()
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42)
                                .foregroundColor(.white)
                        }
                        .disabled(!isValid)
                        .opacity(isValid ? 1 : 0.5)
                    }
                    .frame(width: g.size.width / 1.2)
                }
                .padding(.vertical, 16)
                .frame(width: g.size.width, height: g.size.height)
                .background(Color.mainBlue)
            }
            .onChange(of: selectedPhoto) { photo in
                Task {
                    if let data = try? await photo?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            activeProfile.profilePicture = Image(uiImage: uiImage)
                        }
                    } else {
                        activeProfile.profilePicture = nil
                    }
                }
            }
        } else {
            GeometryReader { g in
                
            }
            .background(Color.mainBlue)
        }
    }
    
    func checkValidity() -> Bool {
        if profile!.wrappedValue.name.isEmpty {
            return false
        }
        
        if user.profiles.contains(where: { p in
            return profile!.wrappedValue.name == p.name && profile!.wrappedValue.id != p.id
        }) {
            return false
        }
        
        return true
    }
    
    func updateValidity() {
        isValid = checkValidity()
    }
    
}

struct ProfileEditSheetNoPicture: View {
    @EnvironmentObject var user: User
    @StateObject var activeProfile: Profile
    @State var initialProfile: Profile? = nil
    @State var isValid: Bool = true
    
    var initialName: String
    var initialImage: Image?
    
    var profileIndex: Int
    var isNewProfile: Bool
    var onDismiss: () -> Void
    
    var profile: Binding<Profile>? {
        if !user.profiles.indices.contains(profileIndex) {
            return nil
        }
        return $user.profiles[profileIndex]
    }
    
    var body: some View {
        if profile != nil {
            GeometryReader { g in
                VStack {
                    HeaderView(
                        text: isNewProfile ? "Add Profile" : "Edit Profile"
                    )
                    .foregroundColor(Color.mainYellow)
                    .padding(.bottom)
                    
                    ZStack(alignment: .topTrailing) {
                        activeProfile
                            .profileCircle(size: g.size.width / 3)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                            .padding(.bottom, 36)
                        
                        if profile!.wrappedValue.profilePicture != nil {
                            Button {
                                activeProfile.profilePicture = nil
                            } label: {
                                ZStack {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                        .padding(.all, 12)
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .bold))
                                }
                                .background(.white)
                                .clipShape(Circle())
                            }
                        }
                    }
                    TextField("Name", text: $activeProfile.name)
                        .padding()
                        .frame(width: g.size.width / 1.2)
                        .background(Color.lighterBlue)
                        .cornerRadius(5.0)
                        .multilineTextAlignment(.center)
                        .font(.customBody())
                        .onChange(of: activeProfile.name) { _ in
                            updateValidity()
                        }
                    Spacer()
                    HStack {
                        Button {
                            if isNewProfile {
                                user.profiles.remove(at: profileIndex)
                            } else {
                                activeProfile.name = initialName
                                if let newImage = initialImage {
                                    activeProfile.profilePicture = newImage
                                } else {
                                    activeProfile.profilePicture = nil
                                }
                                
                            }
                            onDismiss()
                        } label: {
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button {
                            onDismiss()
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42)
                                .foregroundColor(.white)
                        }
                        .disabled(!isValid)
                        .opacity(isValid ? 1 : 0.5)
                    }
                    .frame(width: g.size.width / 1.2)
                }
                .padding(.vertical, 16)
                .frame(width: g.size.width, height: g.size.height)
                .background(Color.mainBlue)
            }
        } else {
            GeometryReader { g in
                
            }
            .background(Color.mainBlue)
        }
    }
    
    func checkValidity() -> Bool {
        if profile!.wrappedValue.name.isEmpty {
            return false
        }
        
        if user.profiles.contains(where: { p in
            return profile!.wrappedValue.name == p.name && profile!.wrappedValue.id != p.id
        }) {
            return false
        }
        
        return true
    }
    
    func updateValidity() {
        isValid = checkValidity()
    }
    
}

struct ProfileOptionView: View {
    @EnvironmentObject var user: User
    
    @State var deleteConfirmation: Bool = false
    
    var profileIndex: Int
    @Binding var editMode: Bool
    var proxy: GeometryProxy
    var action: () -> Void
    
    var body: some View {
        if user.profiles.indices.contains(profileIndex) {
            let profile = user.profiles[profileIndex]
            
            ZStack(alignment: .topTrailing) {
                Button {
                    action()
                } label: {
                    VStack {
                        ZStack {
                            profile.profileCircle(size: proxy.size.width / 3.5)
                                .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                            
                            if editMode {
                                Color.black
                                    .frame(width: proxy.size.width / 3.5, height: proxy.size.width / 3.5)
                                    .clipShape(Circle())
                                    .opacity(0.2)
                                
                                Image(systemName: "pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: proxy.size.width / 9)
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .medium))
                            }
                        }
                        Text(profile.name.isEmpty ? "Placeholder" : profile.name)
                            .font(Font.customBody())
                            .foregroundColor(.white)
                            .opacity(profile.name.isEmpty ? 0 : 1)
                    }
                }
                .foregroundColor(.black)
                .padding(.vertical)
                
                if editMode {
                    Button {
                        deleteConfirmation = true
                    } label: {
                        ZStack {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 14, height: 14)
                                .padding(.all, 12)
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .bold))
                        }
                        .background(.white)
                        .clipShape(Circle())
                    }
                }
            }
            .alert("Delete Profile?", isPresented: $deleteConfirmation) {
                Button("Delete", role: .destructive) {
                    user.profiles.remove(at: profileIndex)
                }
                Button("Cancel", role: .cancel) {
                }
            } message: {
                Text("This cannot be undone")
            }
        } else {
            EmptyView()
        }
    }
}

struct AddProfileView: View {
    var proxy: GeometryProxy
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.init(white: 0.85))
                        .frame(width: proxy.size.width / 3.5, height: proxy.size.width / 3.5)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width / 9)
                        .foregroundColor(Color.init(white: 0.4))
                        .font(.system(size: 20, weight: .medium))
                }
                Text("Add Profile")
                    .font(Font.customBody())
                    .foregroundColor(.white)
            }
        }
        .foregroundColor(.black)
        .padding(.vertical)
    }
}

struct EditButton: View {
    @Binding var editMode: Bool
    var proxy: GeometryProxy
    
    var body: some View {
        Button {
            editMode.toggle()
        } label: {
            HStack {
                if editMode {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .medium))
                    Text("Cancel")
                        .font(.customHeader(size: 20).weight(.medium))
                } else {
                    Image(systemName: "pencil")
                        .font(.system(size: 20, weight: .medium))
                    Text("Edit")
                        .font(.customHeader(size: 20).weight(.medium))
                }
            }
            .frame(width: proxy.size.width / 2)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.mainYellow)
            )
            .foregroundColor(Color.black)
        }
    }
    
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct ChooseUserPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            ChooseUserPage(page: .constant(.chooseUser), proxy: g)
        }
        .environmentObject(TestData.testUser)
    }
}
