//
//  GenerationOptions.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 27/10/2022.
//

class GenerationOptions {
    
    var theme: ChoiceOption
    var setting: ChoiceOption
    var character: ChoiceOption
    var friend: ChoiceOption
    
    var bookTitle: String?
    var characterName: String?
    var friendName: String?
    
    init(theme: ChoiceOption, setting: ChoiceOption, character: ChoiceOption, friend: ChoiceOption, bookTitle: String? = nil, characterName: String? = nil, friendName: String? = nil) {
        self.theme = theme
        self.setting = setting
        self.character = character
        self.friend = friend
        self.bookTitle = bookTitle?.trim().capitalized
        self.characterName = characterName?.trim().capitalized
        self.friendName = friendName?.trim().capitalized
    }
    
}
