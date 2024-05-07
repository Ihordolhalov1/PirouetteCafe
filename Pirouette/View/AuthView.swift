//
//  ContentView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 15.01.2024.
//

import SwiftUI

struct AuthView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    @State private var isAuth = true
    @State private var isTabViewShow = false
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            VStack {
                TextField("Enter your email", text: $email)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color("whiteAlpha"))
                    .foregroundColor(Color.black)
                    .cornerRadius(12)
                    .padding(8)
                
                SecureField("Enter your password", text: $password)
                    .padding()
                    .background(Color("whiteAlpha"))
                    .foregroundColor(Color.black)
                    .cornerRadius(12)
                    .padding(8)
                
                if !isAuth {
                    SecureField("Repeat your password", text: $repeatPassword)
                        .padding()
                        .background(Color("whiteAlpha"))
                        .cornerRadius(12)
                        .padding(8)
                }
                
                Button(action: {
                    if isAuth {
                        print("Login button pressed")
                        
                        AuthService.shared.signIn(email: self.email, password: self.password) { result in
                            switch result {
                            case .success(let user):
                                print("Логін успішний")
                                print(user)
                                DatabaseService.shared.updateToken()

                                isTabViewShow.toggle()
                                
                                
                                
                            case .failure(let error):
                                alertMessage = "Error of authorisation: \(error.localizedDescription)"
                                print("AlertMessage is", alertMessage)
                                self.isShowAlert.toggle()
                                
                            }
                        }
                    } else {
                        print("Sign up button pressed")
                        
                        guard password == repeatPassword else {
                            self.alertMessage = "Passwords are not equal"
                            self.isShowAlert.toggle()
                            return
                        }
                        AuthService.shared.signUp(email: self.email, password: self.password) { result in ////создать DetailedUser
                            switch result {
                            case .success(_):
                                alertMessage = "Registration successful"
                                self.isShowAlert.toggle()
                                self.email = ""
                                self.password = ""
                                self.repeatPassword = ""
                                DatabaseService.shared.updateToken()

                                self.isAuth.toggle()
                                
                            case .failure(let error):
                                alertMessage = "Registration failure \(error.localizedDescription)"
                                self.isShowAlert.toggle()
                                
                            }
                        }
                        
                        
                    }
                }, label: {
                    CustomButton(text: isAuth ? "Log In" : "Sign Up", opacity: 1.0)
                })
                
                if isAuth {
                    if email.contains("@") {
                        Text("Forgot password?")
                            .foregroundStyle(Color(.whiteAlpha))
                            .onTapGesture {
                                alertMessage = "Link to recover password will be sent to email \(email)"
                                AuthService.shared.resetPassword(email: email) { error in
                                    print(error)
                                }
                                self.isShowAlert.toggle()
                                
                            }
                    }
                }
                
            } .padding(.top, 100)
            
            VStack {
                Button(action: {
                    isAuth.toggle()
                }, label: {
                    CustomButton (text: isAuth ? "Sign Up" : "Log In", opacity: 0.6)
                })
            }.padding(.top, 100)
                .alert(alertMessage, isPresented: $isShowAlert) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Ok")
                    })
                }
            
            
            
            
        } .onAppear() {
            AuthService.shared.signOut() //Выгрузить пользователя
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("bg2").ignoresSafeArea())
        .padding()
        .animation(.easeInOut(duration: 0.3), value: isAuth)
        .fullScreenCover(isPresented: $isTabViewShow, content: {
            if AuthService.shared.currentUser?.uid == adminID || AuthService.shared.currentUser?.uid == admin2ID {
                AdminOrderView()
            
        } else {
            let mainTabBarViewModel = MainTabBarViewModel(user: AuthService.shared.currentUser!)
            MainTabBar(viewModel: mainTabBarViewModel)
        }
                         
                         })
    }
}

#Preview {
    AuthView()
}
