//
//  NumberPinPage.swift
//  Story Wizard
//
//  Created by Jacob Curtis on 01/11/2022.
//


import SwiftUI

struct NumberPinPage: View {
    
    @Binding var page: Page
    var proxy: GeometryProxy
    
    @State var pin: String = ""
    
    @EnvironmentObject var user: User
    
    public var body: some View {
        PinPageView(pin: $pin, mainAction: goToChooseUser, submitPin: submitPin, proxy: proxy)
    }
    
    func goToChooseUser(){
        page = .chooseUser
    }
    
    func goToPinPage2(firstPin: String){
        user.numberPin = firstPin
        page = .numberPin2
    }
    
    func isValidPin() -> Bool {
        return pin.count == 4
    }
    
    func submitPin() {
        if isValidPin() {
            goToPinPage2(firstPin: pin)
        }
    }
}

extension String {
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        
        return result
    }
    
}

extension Int {
    
    var numberString: String {
        
        guard self < 10 else { return "0" }
        
        return String(self)
    }
}

struct NumberPinPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            NumberPinPage(page: .constant(.numberPin), proxy: g)
        }
        .environmentObject(TestData.testUser)
    }
}
