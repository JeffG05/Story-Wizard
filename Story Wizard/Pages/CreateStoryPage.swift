//
//  CreateStoryPage.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct CreateStoryPage: View {
    @EnvironmentObject var user: User
    
    @State var currentSlide = 0
    @State var chosenTheme: ChoiceOption? = nil
    @State var chosenSetting: ChoiceOption? = nil
    @State var chosenCharacter: ChoiceOption? = nil
    @State var chosenFriend: ChoiceOption? = nil
    @State var bookTitle: String = TestData.randomTitles.randomElement()!
    @State var characterName: String = TestData.randomName.randomElement()!
    @State var friendName: String = TestData.randomName.randomElement()!
    @State var offsetPage: CGFloat = 0
    
    @Binding var page: Page
    var proxy: GeometryProxy
    
    var body: some View {
        
        let title =
        currentSlide == 0 ? "What will your story be about?" :
        currentSlide == 1 ? "Where will your story be set?" :
        currentSlide == 2 ? "Who is your main character?" :
        currentSlide == 3 ? "Who is your main character's friend?" :
        "Add your final touches!"
        
        
        ZStack(alignment: .leading) {
            BackgroundBubbleView(bubblePosition: .center, proxy: proxy)
                .frame(width: proxy.size.width)
            
            VStack(alignment: .leading) {
                HeaderView(
                    text: title,
                    textSize: 25,
                    leftIcon: "x.square",
                    leftAction: goBack
                )
                .frame(width: proxy.size.width)
                
                HStack(alignment: .center, spacing: 0) {
                    ChoiceSelectionPage(choice: $chosenTheme, type: .theme, proxy: proxy) {
                        currentSlide += 1
                    }
                    
                    ChoiceSelectionPage(choice: $chosenSetting, type: .setting, proxy: proxy) {
                        currentSlide += 1
                    }
                    
                    ChoiceSelectionPage(choice: $chosenCharacter, type: .character, proxy: proxy) {
                        currentSlide += 1
                    }
                    
                    ChoiceSelectionPage(choice: $chosenFriend, type: .character, proxy: proxy) {
                        currentSlide += 1
                    }
                    
                    FinalTouchesPage(bookTitle: $bookTitle, characterName: $characterName, friendName: $friendName, proxy: proxy) {
                        currentSlide += 1
                    }
                }
                .offset(x: offsetPage)
                
                Indicators(currentPage: $currentSlide, proxy: proxy)
                    .padding(.bottom)
            }
            
            if currentSlide == 5 {
                GeneratingStoryPage(proxy: proxy)
            }
        }
        .onChange(of: currentSlide) { _ in
            withAnimation(Animation.easeInOut(duration: 0.25)) {
                offsetPage = -proxy.size.width * CGFloat(currentSlide)
            }
        }
        .onAppear {
            offsetPage = -proxy.size.width * CGFloat(currentSlide)
        }
        .task(id: currentSlide) {
            if currentSlide == 5 {
                await createBook()
            }
        }
    }
    
    func goBack() {
        page = .goBack
    }
    
    func createBook() async {
        let randomWaitTime = CGFloat.random(in: 10...20)
        try? await Task.sleep(nanoseconds: UInt64(randomWaitTime * 1_000_000_000))
        
        let generationOptions = GenerationOptions(
            theme: chosenTheme!,
            setting: chosenSetting!,
            character: chosenCharacter!,
            friend: chosenFriend!,
            bookTitle: bookTitle.isEmpty ? nil : bookTitle,
            characterName: characterName.isEmpty ? nil : characterName,
            friendName: friendName.isEmpty ? nil : friendName
        )
        user.currentProfile?.currentBookIndex = user.currentProfile!.addBook(bookObj: Book.generate(options: generationOptions)) ?? -1
        page = .library
    }
}

struct Indicators: View {
    
    @Binding var currentPage: Int
    var proxy: GeometryProxy
    
    var body: some View {
        HStack(spacing: proxy.size.width / 40) {
            Button {
                currentPage -= 1
            } label: {
                Image(systemName: "chevron.backward")
            }
            .foregroundColor(.black)
            .fontWeight(.semibold)
            .padding(.trailing)
            .disabled(currentPage == 0)
            .opacity(currentPage == 0 ? 0 : 1)
            
            ForEach(0..<5, id: \.self) { i in
                Indicator(selected: i == currentPage, proxy: proxy)
            }
            
            Button {
                currentPage += 1
            } label: {
                Image(systemName: "chevron.forward")
            }
            .foregroundColor(.black)
            .fontWeight(.semibold)
            .padding(.leading)
            .disabled(true)
            .opacity(0)
        }
        .padding(.top)
        .frame(width: proxy.size.width)
    }
}

struct Indicator: View {
    
    var selected: Bool
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .fill(selected ? Color.mainYellow : Color.init(white: 0.9))
            .frame(width: proxy.size.width / 20)
    }
    
}

struct ChoiceSelectionPage: View {
    
    @State var selectedOptions: [ChoiceOption] = []
    
    @Binding var choice: ChoiceOption?
    var type: ChoiceOptionType
    var proxy: GeometryProxy
    var action: () -> Void
    
    var body: some View {
        let colors = [
            Color.init(red: 255/255, green: 90/255, blue: 90/255),
            Color.init(red: 66/255, green: 197/255, blue: 253/255),
            Color.init(red: 255/255, green: 239/255, blue: 100/255),
            Color.init(red: 85/255, green: 193/255, blue: 96/255)
        ]
        
        VStack {
            GeometryReader { g in
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: g.size.width / 15),
                        GridItem(.flexible(), spacing: g.size.width / 15)
                    ],
                    spacing: g.size.width / 15
                ) {
                    ForEach(selectedOptions, id: \.self) { opt in
                        opt.card(proxy: g, color: colors[selectedOptions.firstIndex(of: opt)!]) {
                            choice = opt
                            action()
                        }
                    }
                }
                .padding(.horizontal, g.size.width / 15)
            }
            .onAppear {
                shuffle()
            }
            
            VStack(alignment: .center) {
                Button {
                    shuffle()
                } label: {
                    HStack {
                        Image(systemName: "shuffle")
                        Text("Shuffle")
                    }
                    .frame(width: proxy.size.width * 3/4)
                    .foregroundColor(.black)
                    .font(.customHeader(size: 20))
                    .padding(.vertical, 4)
                    .background(Color.mainYellow)
                    .cornerRadius(100, corners: .allCorners)
                }
            }
            .frame(width: proxy.size.width)
            .padding(.vertical)
            .frame(width: proxy.size.width)
        }
    }
    
    func shuffle() {
        let options = ChoiceOption.options.filter { $0.type == type }
        selectedOptions = options.randomN(n: 4, exclude: selectedOptions)
    }
}

struct FinalTouchesPage: View {
    
    @Binding var bookTitle: String
    @Binding var characterName: String
    @Binding var friendName: String
    var proxy: GeometryProxy
    var action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            TextInput(title: "Book Title", text: $bookTitle, width: proxy.size.width * 3/4)
            
            TextInput(title: "Main Character Name", text: $characterName, width: proxy.size.width * 3/4)
            
            TextInput(title: "Their Friend's Name", text: $friendName, width: proxy.size.width * 3/4)
            
            Spacer()
            
            VStack(alignment: .center) {
                Button {
                    action()
                } label: {
                    Text("Create")
                        .frame(width: proxy.size.width * 3/4)
                        .foregroundColor(.black)
                        .font(.customHeader(size: 20))
                        .padding(.vertical, 4)
                        .background(Color.init(red: 85/255, green: 193/255, blue: 96/255))
                        .cornerRadius(100, corners: .allCorners)
                }
            }
            .frame(width: proxy.size.width)
            .padding(.vertical)
        }
        .padding(.top, proxy.size.height / 25)
    }
    
    struct TextInput: View {
        
        var title: String
        @Binding var text: String
        var width: CGFloat
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Text("\(title):")
                    .font(.customHeader(size: 20))
                
                TextField("Random Suggested Name", text: $text)
                    .padding()
                    .frame(width: width)
                    .background(Color.init(white: 0.85))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .foregroundColor(.black)
                    .font(.customBody(size: 20))
            }
            .frame(width: width)
            
        }
        
    }
    
}

struct GeneratingStoryPage: View {
    
    @State var dots: String = ""
    
    var proxy: GeometryProxy
    
    let timer = Timer.publish(every: 0.75, on: .current, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            BackgroundStarsView()
                .frame(width: proxy.size.width, height: proxy.size.height)
            
            VStack(spacing: 0) {
                Spacer()
                Text("Creating Your Story\(dots)")
                    .font(.customHeader())
                    .foregroundColor(.mainYellow)
                Spacer()
                Image("FullWizzo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width * 0.9)
                Spacer()
                Text("It may take a while!")
                    .font(.customHeader(size: 25))
                    .foregroundColor(.mainYellow)
                Spacer()
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .onReceive(timer) { _ in
            dots += "."
            if dots.count > 3 {
                dots = ""
            }
        }
    }
    
}

class ChoiceOption: Hashable {
    var title: String
    var image: Image
    var type: ChoiceOptionType
    
    init(title: String, image: Image, type: ChoiceOptionType) {
        self.title = title
        self.image = image
        self.type = type
    }
    
    func card(proxy: GeometryProxy, color: Color, action: @escaping () -> Void) -> some View {
        return Button {
            action()
        } label: {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    image
                        .resizable()
                    .scaledToFit()
                    Spacer()
                }
                Spacer()
                Text(title)
                    .font(.customHeader(size: 20))
            }
            .padding(.all)
            .background(color)
            .cornerRadius(8, corners: .allCorners)
            .shadow(radius: 2, y: 4)
        }
        .frame(height: (proxy.size.height - (proxy.size.width / 15)) / 2)
        .foregroundColor(.black)
    }
    
    static func == (lhs: ChoiceOption, rhs: ChoiceOption) -> Bool {
        return lhs.title == rhs.title && lhs.image == rhs.image && lhs.type == rhs.type
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(type)
    }
    
    static var options: [ChoiceOption] {
        return [
            // themes
            ChoiceOption(title: "Space", image: Image("SpaceTheme"), type: .theme),
            ChoiceOption(title: "Dragons", image: Image("DragonsTheme"), type: .theme),
            ChoiceOption(title: "Ninjas", image: Image("NinjasTheme"), type: .theme),
            ChoiceOption(title: "Cars", image: Image("CarsTheme"), type: .theme),
            ChoiceOption(title: "Aeroplanes", image: Image("AeroplaneTheme"), type: .theme),
            ChoiceOption(title: "Dinosaurs", image: Image("DinosaurTheme"), type: .theme),
            
            // settings
            ChoiceOption(title: "Forest", image: Image("ForestSetting"), type: .setting),
            ChoiceOption(title: "Beach", image: Image("BeachSetting"), type: .setting),
            ChoiceOption(title: "Castle", image: Image("CastleSetting"), type: .setting),
            ChoiceOption(title: "School", image: Image("SchoolSetting"), type: .setting),
            ChoiceOption(title: "Submarine", image: Image("SubmarineSetting"), type: .setting),
            ChoiceOption(title: "Haunted House", image: Image("HauntedHouseSetting"), type: .setting),
            
            // characters
            ChoiceOption(title: "A Knight", image: Image("KnightCharacter"), type: .character),
            ChoiceOption(title: "An Alien", image: Image("AlienCharacter"), type: .character),
            ChoiceOption(title: "A Pirate", image: Image("PirateCharacter"), type: .character),
            ChoiceOption(title: "A Girl", image: Image("GirlCharacter"), type: .character),
            ChoiceOption(title: "A Dog", image: Image("DogCharacter"), type: .character),
            ChoiceOption(title: "A Pig", image: Image("PigCharacter"), type: .character),
            ChoiceOption(title: "An Elf", image: Image("ElfCharacter"), type: .character),
            ChoiceOption(title: "A Zombie", image: Image("ZombieCharacter"), type: .character),
            
        ]
    }
    
    static var themes: [ChoiceOption] {
        return ChoiceOption.options.filter({ $0.type == .theme })
    }
    
    static var settings: [ChoiceOption] {
        return ChoiceOption.options.filter({ $0.type == .setting })
    }
    
    static var characters: [ChoiceOption] {
        return ChoiceOption.options.filter({ $0.type == .character })
    }
}

enum ChoiceOptionType {
    case theme, setting, character
}

extension Array where Element : Equatable {
    func randomN(n: Int, exclude: [Element]? = nil) -> [Element] {
        assert(!isEmpty)
        
        var indexes = indices.shuffled()
        var chosen: [Element] = []
        
        for e in (exclude ?? []) {
            indexes.removeAll { self[$0] == e }
        }
        
        while chosen.count < n {
            if indexes.isEmpty {
                indexes = indices.shuffled()
            }
            var i = 1
            while chosen.contains(where: { $0 == self[indexes[indexes.endIndex - i]] }) {
                i += 1
            }
            chosen.append(self[indexes.remove(at: indexes.endIndex - i)])
        }
        
        return chosen
    }
}

struct CreateStoryPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            CreateStoryPage(page: .constant(.createStory), proxy: g)
        }
        .environmentObject(TestData.testUser)
    }
}
