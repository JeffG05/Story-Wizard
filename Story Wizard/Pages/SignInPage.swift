//
//  SignInPage.swift
//  Story Wizard
//
//  Created by Jacob Curtis on 22/10/2022.
//

//Use login details 'User' and 'Password' to sign in

import SwiftUI

struct SignInPage: View {
    
    enum FocusField {
        case email, password
    }
    
    @Binding var page: Page
    var proxy: GeometryProxy
    @EnvironmentObject var user : User
    @State var email: String = ""
    @State var password: String = ""
    @FocusState var focusedField: FocusField?
    
    @State var isSignInValid: Bool = false
    @State var showInvalidDetailsAlert: Bool = false
    var users: [User]
    @Binding var currentUserIndex: Int
    
    @State var showPassword = false
    
    var body: some View {
        ZStack {
            // Background color
            Color.mainBlue
                .ignoresSafeArea()
                .onTapGesture {
                    focusedField = nil
                }
            
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
            .onTapGesture {
                focusedField = nil
            }
            
            // Main screen
            VStack {
                HeaderView(
                    text: "Sign In",
                    iconColor: .mainYellow,
                    textSize: 40,
                    rightIcon: Image(systemName: "questionmark.circle"),
                    rightAction: goToWalkthrough
                )
                .padding(.bottom, 30)
                .foregroundColor(.mainYellow)
                
                VStack(spacing: 0) {
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .email)
                        .padding()
                        .frame(width: proxy.size.width / 1.2)
                        .background(Color.starBlue)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    ZStack{
                        if showPassword{
                            TextField("Password", text: $password)
                                .textContentType(.password)
                                .submitLabel(.return)
                                .focused($focusedField, equals: .password)
                                .padding()
                                .frame(width: proxy.size.width / 1.2)
                                .background(Color.starBlue)
                                .cornerRadius(5.0)
                                .padding(.bottom, 20)
                                .onChange(of: $focusedField.wrappedValue) { _ in
                                    if focusedField == .password {
                                        password = ""
                                    }
                            }
                            
                        } else {
                            SecureField("Password", text: $password)
                                .textContentType(.password)
                                .submitLabel(.return)
                                .focused($focusedField, equals: .password)
                                .padding()
                                .frame(width: proxy.size.width / 1.2)
                                .background(Color.starBlue)
                                .cornerRadius(5.0)
                                .padding(.bottom, 20)
                                .onChange(of: $focusedField.wrappedValue) { _ in
                                    if focusedField == .password {
                                        password = ""
                                    }
                            }
                
                        }
                        showPasswordButton
                            .offset(x:UIScreen.main.bounds.width/2.8,y:-10)
                        
                    }
                    
                }
                .onSubmit {
                    switch focusedField {
                    case .email:
                        focusedField = .password
                    default:
                        focusedField = nil
                    }
                    
                }
                
                
                SignInButton(proxy: proxy, text:"Sign In"){
                    focusedField = nil
                    checkSignIn()
                }
                .alert(isPresented: $showInvalidDetailsAlert) {
                        Alert(title: Text("Incorrect Email/Password"))
                }
                
                Spacer()
                    .onTapGesture {
                        focusedField = nil
                    }
                
                RegisteredYNButton(proxy: proxy, text: "Not registered? Sign Up"){
                    goToSignUp()
                }
                
                
            }
            .ignoresSafeArea(.keyboard)
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .ignoresSafeArea()
    }
    
    func checkSignIn () {
        
        var found = false
        //trigger logic
        
            self.isSignInValid = true //trigger NavigationLink
        for index in 0..<users.count {
                if users[index].email == self.email && users[index].password == self.password {
                    self.currentUserIndex = index
                    found = true
                }
            }
        if found {
            if user.numberPin == nil {
                goToNumberPin()
            } else {
                goToChooseUser()
            }
        } else {
            self.showInvalidDetailsAlert = true
        }
        
        
    }
    
    func goToNumberPin() {
        page = .numberPin
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
    
    private var showPasswordButton: some View {
        Button(action: {
            self.showPassword.toggle()
        }, label: {
            self.showPassword ?
                Image(systemName: "eye.slash.fill").foregroundColor(.mainYellow) :
                Image(systemName: "eye.fill").foregroundColor(.mainYellow)
        })
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
                    .font(.customHeader(size: 20).weight(.medium))
            }
            .frame(width: proxy.size.width / 1.5, height: proxy.size.height/30)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.mainYellow)
            )
            .foregroundColor(Color.black)
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
                    .font(.customHeader(size: 20).weight(.medium))
            }
            .frame(width: proxy.size.width/1.2)
            .padding(.vertical, 12)
            .foregroundColor(Color.mainYellow)
        }
    }
    
}

struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            SignInPage(page: .constant(.signIn), proxy: g, users: [TestData.testUser], currentUserIndex: .constant(0))
        }
        .environmentObject(TestData.testUser)
    }
}
