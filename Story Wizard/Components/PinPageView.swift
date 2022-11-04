//
//  PinPageView.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 03/11/2022.
//

import SwiftUI

struct PinPageView: View {
    @Binding var pin: String
    var confirmPin: String? = nil
    var mainAction: () -> Void
    var submitPin: () -> Void
    var enterUserPin: Bool = false
    var proxy: GeometryProxy
    
    @FocusState var pinFocused: Bool
    @State var showPin = false
    
    var body: some View {
        ZStack {
            Color.mainBlue
                .ignoresSafeArea()
            
            BackgroundStarsView()
            
            VStack(spacing: 10) {
                HeaderView(
                    text: "Enter Security Pin"
                )
                .foregroundColor(.mainYellow)
                
                let text = enterUserPin ? "Please enter security pin to access user settings" : isConfirmingPin() ? "Please confirm your\nsecurity pin code." : "Set a pin code to secure\nyour settings."
                
                Text(text)
                    .font(Font.customHeader(size:20))
                    .foregroundColor(.mainYellow)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                ZStack {
                    pinDots
                    backgroundField
                }
                .padding(.top)
                
                showPinStack
                
                if isConfirmingPin() {
                    Button {
                        mainAction()
                    } label: {
                        Text("Back")
                            .font(.customBody(size: 18))
                            .frame(width: proxy.size.width * 0.66)
                            .padding(.vertical, 15)
                            .foregroundColor(.black)
                    }
                    .background(Color.mainYellow)
                    .cornerRadius(12, corners: .allCorners)
                } else {
                    Button {
                        mainAction()
                    } label: {
                        VStack {
                            Text("Skip")
                                .font(.customBody(size: 18))
                            Text("Not recommended")
                                .font(.customBody(size: 12))
                                .italic()
                        }
                        .frame(width: proxy.size.width * 0.66)
                        .padding(.vertical, 8)
                        .foregroundColor(.black)
                    }
                    .background(Color.mainYellow)
                    .cornerRadius(12, corners: .allCorners)
                }
                    
                Spacer()
            }
            .frame(height: proxy.size.height)
        }
        .frame(height: proxy.size.height)
        
    }
    
    func isConfirmingPin() -> Bool {
        return confirmPin != nil
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
        
        return TextField("", text: boundPin)
            .focused($pinFocused)
           .accentColor(.clear)
           .foregroundColor(.clear)
           .keyboardType(.numberPad)
           .textSelection(.disabled)
           .onAppear {
               pinFocused = true
           }
           .onChange(of: pin) { _ in
               pin = String(pin.prefix(while: { $0.isNumber }).prefix(4))
           }
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

struct PinPageView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            PinPageView(pin: .constant(""), mainAction: {}, submitPin: {}, proxy: g)
        }
    }
}
