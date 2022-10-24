//
//  HeaderView.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var user: User
    
    var text: String
    var iconSize: CGFloat = 32
    var textSize: CGFloat = 32
    var showProfile: Bool = false
    var leftIcon: String?
    var rightIcon: String?
    var profileAction: (() -> Void)?
    var leftAction: (() -> Void)?
    var rightAction: (() -> Void)?

    var body: some View {
        let hPad = 24 + (showProfile ? 42 : 0) + (leftIcon != nil || rightIcon != nil ? iconSize : 0) + 8
        
        
        ZStack(alignment: .top) {
            HStack(alignment: .center) {
                Text(text)
                    .font(Font.customHeader(size: textSize))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, hPad)
            HStack {
                if showProfile {
                    Button {
                        profileAction?()
                    } label: {
                        user.currentProfile!.profileCircle(size: 42)
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
            HeaderView(text: "Welcome Child 123456", rightIcon: "arrow.right")
            Spacer()
        }
        .environmentObject(TestData.testUser)
    }
}
