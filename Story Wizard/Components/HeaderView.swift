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
    var iconColor: Color = .black
    var textSize: CGFloat = 32
    var showProfile: Bool = false
    var leftIcon: Image?
    var rightIcon: Image?
    var middleIcon: Image?
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
                        IconButton(icon: icon, size: iconSize, color: iconColor) {
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
                if let icon = leftIcon {
                    IconButton(icon: icon, size: iconSize, color: iconColor) {
                        leftAction?()
                    }
                }
                Spacer()
                if let icon = rightIcon {
                    IconButton(icon: icon, size: iconSize, color: iconColor) {
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
            HeaderView(rightIcon: Image(uiImage: UIImage(named: "back")!.withHorizontallyFlippedOrientation()), middleIcon: Image(systemName: "speaker.wave.2"))
            Spacer()
        }
        .environmentObject(TestData.testUser)
    }
}
