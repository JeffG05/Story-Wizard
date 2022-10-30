//
//  SignInPage.swift
//  Story Wizard
//
//  Created by Jacob Curtis on 22/10/2022.
//

//Use login details 'User' and 'Password' to sign in

import SwiftUI

struct SignInPage: View {
    
    @Binding var page: Page
    var proxy: GeometryProxy
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var isSignInValid: Bool = false
    @State var showInvalidDetailsAlert: Bool = false
    
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
                    text: "Sign In",
                    textSize: 40,
                    rightIcon: "questionmark.circle",
                    rightAction: goToWalkthrough
                )
                .padding(.bottom, 30)
                .foregroundColor(.mainYellow)
                
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
                
                SignInButton(proxy: proxy, text:"Sign In"){
                    checkSignIn()
                }
                .alert(isPresented: $showInvalidDetailsAlert) {
                        Alert(title: Text("Incorrect Email/Password"))
                }
                
                Spacer()
                
                RegisteredYNButton(proxy: proxy, text: "Not registered? Sign Up"){
                    goToSignUp()
                }
                
                
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .ignoresSafeArea()
    }
    
    func checkSignIn () {
        let isSignInValid = self.email == "User" && self.password == "Password"
        
        
        
        //trigger logic
        if isSignInValid {
            self.isSignInValid = true //trigger NavigationLink
            goToChooseUser()
        }
        else {
            self.showInvalidDetailsAlert = true
        }
    }
    
    func goToChooseUser() {
        page = .chooseUser
    }
    
    func goToSignUp() {
        page = .signUp
    }
    
    func goToWalkthrough() {
        page = .walkthrough
    }
    
}

struct SignInButton: View {
    var proxy: GeometryProxy
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button {
           action()
        } label: {
            HStack {
                Text(text)
            }
            .frame(width: proxy.size.width / 2)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.mainYellow)
            )
            .foregroundColor(Color.black)
            .fontWeight(.medium)
        }
    }
    
}

struct RegisteredYNButton: View {
    var proxy: GeometryProxy
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button {
           action()
        } label: {
            HStack {
                Text(text)
            }
            .frame(width: proxy.size.width / 1.6)
            .padding(.vertical, 12)
            .foregroundColor(Color.mainYellow)
            .fontWeight(.medium)
        }
    }
    
}


struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            SignInPage(page: .constant(.signIn), proxy: g)
        }
        .environmentObject(TestData.testUser)
    }
}
