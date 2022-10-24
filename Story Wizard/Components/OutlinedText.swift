//
//  OutlinedText.swift
//  Story Wizard
//
//  Created by jack rathbone on 24/10/2022.
//

import SwiftUI

struct OutlinedText: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}

struct OutlinedText_Previews: PreviewProvider {
    static var previews: some View {
        OutlinedText(text: "Hello World", width: 1.5, color: Color.white)
    }
}
