//
//  CustomFont.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//
import SwiftUI

enum CustomFont {
    case mainBody
    case header
    
    // TODO: Update to custom fonts
    var font: Font {
        switch self {
        case .mainBody:
            return .system(size: 20)
        case .header:
            return .system(size: 32)
        }
    }
}
