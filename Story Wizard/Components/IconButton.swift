//
//  IconButton.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct IconButton: View {
    var icon: String
    var size: CGFloat = 32
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundColor(.black)
        }
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(icon: "arrow.left") {
            print("Click")
        }
    }
}
