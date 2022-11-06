//
//  IconButton.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct IconButton: View {
    var icon: Image
    var size: CGFloat = 32
    var color: Color = .black
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            icon
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundColor(color)
        }
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(icon: Image("back")) {
            print("Click")
        }
    }
}
