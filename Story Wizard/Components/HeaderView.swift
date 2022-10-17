//
//  HeaderView.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct HeaderView: View {
    var text: String
    var profile: Profile?
    var iconSize: CGFloat = 32
    var leftIcon: String?
    var rightIcon: String?
    var profileAction: (() -> Void)?
    var leftAction: (() -> Void)?
    var rightAction: (() -> Void)?

    var body: some View {
        let hPad = 24 + (profile != nil ? 42 : 0) + (leftIcon != nil || rightIcon != nil ? iconSize : 0) + 8
        
        
        ZStack(alignment: .top) {
            HStack(alignment: .center) {
                Text(text)
                    .font(CustomFont.header.font)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, hPad)
            HStack {
                if profile != nil {
                    Button {
                        profileAction?()
                    } label: {
                        profile!.profileCircle(size: 42)
                    }
                    .foregroundColor(.black)
                }
                if leftIcon != nil {
                    IconButton(icon: leftIcon!, size: iconSize) {
                        leftAction?()
                    }
                }
                Spacer()
                if rightIcon != nil {
                    IconButton(icon: rightIcon!, size: iconSize) {
                        rightAction?()
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .padding(.vertical, 8)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HeaderView(text: "Welcome Child 123456", profile: TestData.testProfile, rightIcon: "arrow.right")
            Spacer()
        }
    }
}
