//
//  SettingsPinPage.swift
//  Story Wizard
//
//  Created by Jordan Saphir on 04/11/2022.
//

import SwiftUI

struct SettingsPinPage: View {
    
    @Binding var page: Page
    var proxy: GeometryProxy
    
    @State var pin: String = ""
    @State var showPin = false
    @State var isDisabled = false
    @State var incorrectPin: Bool = false
    
    @EnvironmentObject var user: User
 
    public var body: some View {
//        Color.mainBlue
//            .ignoresSafeArea()
//        BackgroundStarsView()
//        VStack(spacing: 10) {
//            HeaderView(
//                text: "Pin Required",
//                leftIcon: "arrow.left",
//                leftAction: goBack
//            )
//                .font(Font.customHeader(size: 40))
//                .foregroundColor(.mainYellow)
//                .fontWeight(.bold)
//
//            Text("Please enter password to access user settings")
//                .font(Font.customHeader(size:20))
//                .frame(width: 380)
//                .foregroundColor(.mainYellow)
//                .multilineTextAlignment(.center)
//
//        ZStack {
//            pinDots
//            backgroundField
//        }
//        showPinStack
//
//        .alert(isPresented: $incorrectPin) {
//            Alert(title: Text("Pins do not match."))
//        }
//
//        Button("Enter Settings", action: checkPin)
//            .buttonStyle(.bordered)
//            .background(
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(Color.mainYellow))
//            .foregroundColor(.black)
//
//        }
        
        PinPageView(
            pin: $pin,
            confirmPin: user.numberPin,
            mainAction: goBack,
            submitPin: submitPin,
            enterUserPin: true,
            proxy: proxy
        )
        .alert("Incorrect pin", isPresented: $incorrectPin) {
            Button("Ok", role: .cancel) {
                pin = ""
            }
        }
    }
    
    func goBack() {
        page = .chooseUser
    }
    
    func goToSettings(){
        page = .settings
    }
    
    func isValidPin() -> Bool {
        return pin.count == 4
    }
    
    func submitPin() {
        if isValidPin() {
            if pin == user.numberPin {
                goToSettings()
            } else {
                incorrectPin = true
            }
        }
    }
}

struct SettingsPinPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            SettingsPinPage(page: .constant(.settingsPin), proxy: g)
        }
        .environmentObject(TestData.testUser)
    }
}
