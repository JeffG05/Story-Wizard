//
//  SignUpPage.swift
//  Story Wizard
//
//  Created by Jacob Curtis on 22/10/2022.
//

import SwiftUI

struct SignUpPage: View {
    
    enum FocusField {
        case name, email, password, readingAge
    }
    
    @Binding var page: Page
    var proxy: GeometryProxy
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var readingAge: String = ""
    @FocusState var focusedField: FocusField?
    
    @State var isSignUpValid: Bool = false
    @State var showInvalidDetailsAlert: Bool = false
    @State var showPassword: Bool = false
    @Binding var userList: [User]
    
    
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
                    text: "Sign Up",
                    textSize: 40
                )
                .font(.customHeader(size: 20))
                .padding(.bottom, 30)
                .foregroundColor(.mainYellow)
                .onTapGesture {
                    focusedField = nil
                }
                
                VStack(spacing: 0) {
                    TextField("Name", text: $name)
                        .textContentType(.givenName)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .name)
                        .padding()
                        .frame(width: proxy.size.width / 1.2)
                        .background(Color.starBlue)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .email)
                        .padding()
                        .frame(width: proxy.size.width / 1.2)
                        .background(Color.starBlue)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    
                    TextField("Reading Age", text: $readingAge)
                        .keyboardType(.numberPad)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .readingAge)
                        .padding()
                        .frame(width: proxy.size.width / 1.2)
                        .background(Color.starBlue)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                        .onChange(of: readingAge) { _ in
                            readingAge = String(readingAge.prefix(while: { $0.isNumber }))
                        }
                    
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
                    case .name:
                        focusedField = .email
                    case .email:
                        focusedField = .readingAge
                    default:
                        focusedField = nil
                    }
                }
                
                SignInButton(proxy: proxy, text:"Sign Up"){
                    focusedField = nil
                    checkSignUp()
                }
                
                .alert(isPresented: $showInvalidDetailsAlert) {
                    Alert(title: Text("There are some empty fields."))
                }
                
                Spacer()
                    .onTapGesture {
                        focusedField = nil
                    }
                
                RegisteredYNButton(proxy: proxy, text:"Already registered? Sign In"){
                    goToSignIn()
                }
                
                
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .ignoresSafeArea()
    }
    
    func checkSignUp() {
        let isSignUpValid = self.email.isEmpty==false && self.password.isEmpty == false
        
        //trigger logic
        if isSignUpValid {
            self.isSignUpValid = true //trigger NavigationLink
            userList.append(User(name: self.name, email: self.email, password: self.password, numberPin: nil, profiles: []))
            goToSignIn()
        }
        else {
            self.showInvalidDetailsAlert = true
        }
    }
    
    func goToSignIn() {
        page = .signIn
    }
    
    func goToSignUp() {
        page = .chooseUser
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

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            SignUpPage(page: .constant(.signUp), proxy: g, userList: .constant([]))
        }
        .environmentObject(TestData.testUser)
    }
}

