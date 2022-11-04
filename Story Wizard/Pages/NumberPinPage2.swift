//
//  NumberPinPage.swift
//  Story Wizard
//
//  Created by Jacob Curtis on 01/11/2022.
//


import SwiftUI

struct NumberPinPage2: View {
    
    @Binding var page: Page
    var proxy: GeometryProxy
    
    @State var pin: String = ""
    @State var incorrectPin: Bool = false
    
    @EnvironmentObject var user: User
 
    public var body: some View {
        PinPageView(pin: $pin, confirmPin: user.numberPin, mainAction: goToPinPage1, submitPin: submitPin, proxy: proxy)
            .alert("Pins do not match", isPresented: $incorrectPin) {
                Button("Ok", role: .cancel) {
                    pin = ""
                }
            }
    }
    
    func goBack() {
        page = .goBack
    }
    
    func goToPinPage1(){
        user.numberPin = ""
        page = .numberPin
    }
    
    func goToChooseUser(){
        page = .chooseUser
    }
    
    func isValidPin() -> Bool {
        return pin.count == 4
    }
    
    func submitPin() {
        if isValidPin() {
            if pin == user.numberPin {
                goToChooseUser()
            } else {
                incorrectPin = true
            }
        }
    }
}

struct NumberPinPage2_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            NumberPinPage2(page: .constant(.numberPin2), proxy: g)
        }
        .environmentObject(TestData.testUser)
    }
}
