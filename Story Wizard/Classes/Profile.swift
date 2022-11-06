//
//  Profile.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

public enum FilterType: Int {
    case alphabetical  // section1 is explicitly 0. You can start at any value.
    case date_added
    case bookmarked
    case liked
}

public enum TextSize: Int {
    case small
    case medium
    case large
}

class Profile: Hashable, Identifiable, ObservableObject {
    var id: UUID
    var name: String
    @Published var profilePicture: Image?
    var profileColor: Color
    @Published var library: [Book] // library array stores book objects
    @Published var libraryRender: [Book]
    @Published var filterType: FilterType?
    @Published var currentBookIndex: Int
    @Published var readingAge: Int
    @Published var textSize: TextSize?
    @Published var dyslexicMode: Bool
    
init(name: String, profilePicture: Image? = nil, profileColor: Color) {
        self.id = UUID()
        self.name = name
        self.profilePicture = profilePicture
        self.library = [] // stores original order of books
        self.libraryRender = [] // order of books changed depending on filter. This is what is rendered in library page
        self.filterType = .date_added
        self.currentBookIndex = -1// initialise empty library on profile creation
        self.profileColor = profileColor
        self.readingAge = 10
        self.textSize = .medium
        self.dyslexicMode = false
        
    }
    
    static func defaultProfilePicture(color: Color) -> some View {
        ZStack {
            Image("Headshot")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .opacity(0.3)
        }
        .background(color)
    }
    
    static var profileColorOptions: [Color] {
        return [
            .blue,
            .red,
            .purple,
            .green,
            .cyan,
            .orange,
            .mint,
        ]
    }
    
    func profileCircle(size: CGFloat = 42) -> some View {
        ZStack {
            if profilePicture != nil {
                profilePicture!
                    .resizable()
                    .scaledToFill()
            } else {
                Profile.defaultProfilePicture(color: profileColor)
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
    
    func bookmark(id: UUID) {
        for i in 0..<library.count {
            if library[i].id == id {
                library[i].bookmark()
                break
            }
        }
        for i in 0..<libraryRender.count {
            if libraryRender[i].id == id {
                libraryRender[i].bookmark()
                break
            }
        }
    }
    
    func addBook(bookObj: Book) -> Int? {
        library.append(bookObj)
        libraryRender.append(bookObj)
        sort_library()
        return libraryRender.firstIndex(of: bookObj)
    }
    func removeBook(id: UUID) {
        for i in 0..<library.count {
            if library[i].id == id {
                library.remove(at: i)
                break
            }
        }
        for i in 0..<libraryRender.count {
            if libraryRender[i].id == id {
                libraryRender.remove(at: i)
                break
            }
        }
    }
    func rateBook(id: UUID, rating: Rating) {
        for i in 0..<library.count {
            if library[i].id == id {
                library[i].rate(rating: rating)
                break
            }
        }
        for i in 0..<libraryRender.count {
            if libraryRender[i].id == id {
                libraryRender[i].rate(rating: rating)
                break
            }
        }
    }
    func setCurrentBook(index: Int) {
        self.currentBookIndex = index
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.name == rhs.name && lhs.profilePicture == rhs.profilePicture
    }
    
    func sort_library() -> Void {
        switch filterType {
        case .alphabetical:
            libraryRender = library.sorted{ $0.title <= $1.title }
        case .date_added:
            libraryRender = library
        case .bookmarked:
            libraryRender = library.filter{ $0.bookmarked == true }
        case .liked:
            libraryRender = library.filter{ $0.rating == .LIKE }
        case .none:
            break
        }
    }

    func convertFontSize() -> CGFloat {
        switch textSize {
        case .small:
            return 15
        case .medium:
            return 25
        case .large:
            return 30
        case .none:
            return -1
        }
    }
    
    
    func incrementReadingAge() -> Void {
        readingAge += 1
    }
    
    func decrementReadingAge() -> Void {
        readingAge += -1
    }
}

#if os(iOS)
public extension View {
    
    func snapshot(origin: CGPoint = .zero, size: CGSize) -> Image {
        let window = UIWindow(frame: CGRect(origin: origin, size: size))
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return Image(uiImage: hosting.view.renderedImage)
    }
}

private extension UIView {
    
    var renderedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
#endif

struct ProfileCircle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach(Profile.profileColorOptions, id: \.self) { color in
                Profile.defaultProfilePicture(color: color)
                    .frame(width: 50, height: 50)
            }
        }
    }
}
