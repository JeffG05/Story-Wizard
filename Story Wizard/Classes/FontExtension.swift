//
//  FontExtension.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//
import SwiftUI

extension Font {
    static func customBody(size: CGFloat = 20) -> Font {
        return .system(size: size)
    }
    
    static func customHeader(size: CGFloat = 32) -> Font {
        return Font.custom("GloriaHallelujah", size: size)
    }    
}
