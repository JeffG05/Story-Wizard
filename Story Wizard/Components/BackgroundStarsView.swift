//
//  BackgroundStarsView.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 23/10/2022.
//

import SwiftUI

struct BackgroundStarsView: View {
    var body: some View {
        
        ZStack {
            Color.mainBlue
            Image("Stars")
                .resizable()
                .scaledToFill()
                .opacity(0.3)
        }
        .ignoresSafeArea()
    }
}

struct BackgroundStarsView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            BackgroundStarsView()
        }
        .ignoresSafeArea()
    }
}
