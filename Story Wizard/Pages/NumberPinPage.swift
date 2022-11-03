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
    @State var showPin = false
    @State var isDisabled = false
    
    @EnvironmentObject var user: User
    
    public var body: some View {
        Color.mainBlue
            .ignoresSafeArea()
        
        BackgroundStarsView()
        
        VStack(spacing: 10) {
            HeaderView(
                text: "Enter Password"
            )
            .font(Font.customHeader(size: 40))
            .foregroundColor(.mainYellow)
            .fontWeight(.bold)
            
            Text("Set a pin code to secure your settings.")
                .font(Font.customHeader(size:20))
                .frame(width: 380)
                .foregroundColor(.mainYellow)
                .multilineTextAlignment(.center)
            
            ZStack {
                pinDots
                backgroundField
            }
            
            showPinStack
            
            
            Button {
                checkPin()
            } label: {
                Text("Re-enter Password")
                    .frame(width: proxy.size.width * 0.66)
                    .padding(.vertical, 12)
                    .foregroundColor(.black)
            }
            .background(Color.mainYellow)
            .cornerRadius(12, corners: .allCorners)
            
            Button {
                goToChooseUser()
            } label: {
                Text("Skip")
                    .frame(width: proxy.size.width * 0.66)
                    .padding(.vertical, 12)
                    .foregroundColor(.black)
            }
            .background(Color.mainYellow)
            .cornerRadius(12, corners: .allCorners)
            .padding(.top, 8)
            
        }
    }
    
    func goToChooseUser(){
        page = .chooseUser
    }
    
    func goToPinPage2(firstPin: String){
//        print(firstPin)
        user.numberPin = firstPin
        page = .numberPin2
    }
    
    func checkPin(){
        
        guard !pin.isEmpty else {
            showPin = false
            print("Empty")
            return
        }
        
        if pin.count == 4 {
            goToPinPage2(firstPin: pin)

        }
    }
    
    private var pinDots: some View {
        HStack {
            Spacer()
            ForEach(0..<4) { index in
                Image(systemName: self.getImageName(at: index))
                    .font(.system(size: 60, weight: .thin, design: .default))
                    .foregroundColor(.mainYellow)
                Spacer()
            }
        }
    }
    
    private var backgroundField: some View {
        let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
            self.pin = newValue
            self.submitPin()
        })
        
        return TextField("", text: boundPin, onCommit: submitPin)

           .accentColor(.clear)
           .foregroundColor(.clear)
           .keyboardType(.numberPad)
           .disabled(isDisabled)
    }
    
    private var showPinStack: some View {
        HStack {
            Spacer()
            if !pin.isEmpty {
                showPinButton
            }
        }
        .frame(height: 30)
        .padding([.trailing])
    }
    
    private var showPinButton: some View {
        Button(action: {
            self.showPin.toggle()
        }, label: {
            self.showPin ?
                Image(systemName: "eye.slash.fill").foregroundColor(.mainYellow) :
                Image(systemName: "eye.fill").foregroundColor(.mainYellow)
        })
    }
    
    private func submitPin() {
        
        guard !pin.isEmpty else {
            showPin = false
            return
        }
        
        if pin.count == 4 {
            print("Test")

        }
    }
    
    private func getImageName(at index: Int) -> String {
        if index >= self.pin.count {
            return "circle"
        }
        
        if self.showPin {
            return self.pin.digits[index].numberString + ".circle"
        }
        
        return "circle.fill"
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
