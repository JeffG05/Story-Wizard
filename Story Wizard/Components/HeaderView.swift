//
//  HeaderView.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var user: User
    
    var text: String?
    var iconSize: CGFloat = 32
    var textSize: CGFloat = 32
    var showProfile: Bool = false
    var leftIcon: String?
    var rightIcon: String?
    var middleIcon: String?
    var middleDisabled: Bool = false
    var profileAction: (() -> Void)?
    var leftAction: (() -> Void)?
    var rightAction: (() -> Void)?
    var middleAction: (() -> Void)?

    var body: some View {
        let hPad = 24 + (showProfile ? 42 : 0) + (leftIcon != nil || rightIcon != nil ? iconSize : 0) + 8
        
        
        ZStack(alignment: .top) {
            HStack(alignment: .center) {
                VStack {
                    if let title = text {
                        Text(verbatim: title)
                            .font(Font.customHeader(size: textSize))
                            .multilineTextAlignment(.center)
                    }
                    if let icon = middleIcon {
                        IconButton(icon: icon, size: iconSize) {
                            middleAction?()
                        }
                        .disabled(middleDisabled)
                        .opacity(middleDisabled ? 0.5 : 1)
                    }
                }
            }
            .padding(.horizontal, hPad)
            HStack {
                if showProfile {
                    Button {
                        profileAction?()
                    } label: {
                        user.currentProfile!.profileCircle(size: 42)
                    }
                    
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
            HeaderView(rightIcon: "arrow.right",middleIcon: "speaker.wave.2")
            Spacer()
        }
        .environmentObject(TestData.testUser)
    }
}
