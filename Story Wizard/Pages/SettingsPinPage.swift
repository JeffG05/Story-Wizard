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
        Color.mainBlue
            .ignoresSafeArea()
        BackgroundStarsView()
        VStack(spacing: 10) {
            HeaderView(
                text: "Pin Required",
                leftIcon: "arrow.left",
                leftAction: goBack
            )
                .font(Font.customHeader(size: 40))
                .foregroundColor(.mainYellow)
                .fontWeight(.bold)
            
            Text("Please enter password to access user settings")
                .font(Font.customHeader(size:20))
                .frame(width: 380)
                .foregroundColor(.mainYellow)
                .multilineTextAlignment(.center)
    
        ZStack {
            pinDots
            backgroundField
        }
        showPinStack
            
        .alert(isPresented: $incorrectPin) {
            Alert(title: Text("Pins do not match."))
        }
        
        Button("Enter Settings", action: checkPin)
            .buttonStyle(.bordered)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.mainYellow))
            .foregroundColor(.black)
            
        }
    }
    
    func goBack() {
        page = .goBack
    }
    
    func goToSettings(){
        page = .settings
    }
    
    func checkPin(){
        guard !pin.isEmpty else {
            showPin = false
            print("Empty")
            return
        }
        
        if pin.count == 4 && pin==user.numberPin {
            goToSettings()

        }
        
        else {
            incorrectPin=true
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

struct SettingsPinPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            SettingsPinPage(page: .constant(.settingsPin), proxy: g)
        }
        .environmentObject(TestData.testUser)
    }
}
