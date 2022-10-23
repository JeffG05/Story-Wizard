//
//  SignUpPage.swift
//  Story Wizard
//
//  Created by Jacob Curtis on 22/10/2022.
//

//
//  HomePage.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 17/10/2022.
//

import SwiftUI

struct SignUpPage: View {
    
    @Binding var page: Page
    var proxy: GeometryProxy
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var readingAge: Int = 0
    
    
    var body: some View {
        ZStack {
            // Background color
            Color.mainBlue
                .ignoresSafeArea()
            
            // Background star
            VStack {
                Spacer()
                Image("Star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width * 1.2)
                    .opacity(0.3)
                    .rotationEffect(.degrees(40))
            }
            .frame(width: proxy.size.width)
            
            // Main screen
            VStack {
                HeaderView(
                    text: "Sign Up",
                    textSize: 40
                )
                .padding(.bottom, 30)
                .foregroundColor(.mainYellow)
                
                TextField("Name", text: $name)
                    .padding()
                    .frame(width: proxy.size.width / 1.2)
                    .background(Color.starBlue)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                TextField("Email", text: $email)
                    .padding()
                    .frame(width: proxy.size.width / 1.2)
                    .background(Color.starBlue)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: proxy.size.width / 1.2)
                    .background(Color.starBlue)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                TextField("Reading Age", value: $readingAge, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                    .padding()
                    .frame(width: proxy.size.width / 1.2)
                    .background(Color.starBlue)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                SignInButton(proxy: proxy, text:"Sign Up"){
                    goToSignIn()
                }
                
                Spacer()
                
                RegisteredYNButton(proxy: proxy, text:"Already registered? Sign In"){
                    goToSignIn()
                }
                
                
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .ignoresSafeArea()
    }
    
    func goToSignIn() {
        page = .signIn
    }
    
    func goToSignUp() {
        page = .chooseUser
    }
    
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            SignUpPage(page: .constant(.signUp), proxy: g)
        }
    }
}
