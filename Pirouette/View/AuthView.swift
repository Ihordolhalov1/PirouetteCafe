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
                    .padding()
                    .background(Color("whiteAlpha"))
                    .cornerRadius(12)
                    .padding(8)
                
                SecureField("Enter your password", text: $password)
                    .padding()
                    .background(Color("whiteAlpha"))
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
                            case .success(_):
                                isTabViewShow.toggle()

                            case .failure(let error):
                                alertMessage = "Error of authorisation: \(error.localizedDescription)"
                            }
                        }
                    } else {
                        print("Sign up button pressed")
                        
                        guard password == repeatPassword else {
                            self.alertMessage = "Passwords are not equal"
                            self.isShowAlert.toggle()
                            return
                        }
                        AuthService.shared.signUp(email: self.email, password: self.password) { result in
                            switch result {
                            case .success(_):
                                alertMessage = "Registration successful"
                                self.isShowAlert.toggle()
                                self.email = ""
                                self.password = ""
                                self.repeatPassword = ""
                                self.isAuth.toggle()
                                   
                            case .failure(let error):
                                alertMessage = "Registration failure \(error.localizedDescription)"
                                self.isShowAlert.toggle()

                            }
                        }
                        
                       
                    }
                }, label: {
                    Text(isAuth ? "Log In" : "Sign Up")
                })
                .padding()
                .frame(maxWidth: .infinity)
                .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(12)
                .padding(8)
                .font(.title3.bold())
                .foregroundColor(.black)
                
                if isAuth {
                    Text("Forgot password?")
                        .foregroundStyle(Color(.whiteAlpha))
                        .onTapGesture {
                            print("Forgot password")
                        }
                }

            } .padding(.top, 100)

                VStack {
                    Button(action: {
                        isAuth.toggle()
                    }, label: {
                        Text(isAuth ? "Sign Up" : "Log In")
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(colors: [.white, .orange], startPoint: .leading, endPoint: .trailing))
                    .opacity(0.6)
                    .cornerRadius(12)
                    .padding(8)
                    .font(.title3.bold())
                .foregroundColor(.black)
                }.padding(.top, 100)
                .alert(alertMessage, isPresented: $isShowAlert) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Ok")
                    })
                }

            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("bg2").ignoresSafeArea())
        .padding()
        .animation(.easeInOut(duration: 0.3), value: isAuth)
        .fullScreenCover(isPresented: $isTabViewShow, content: {
            if AuthService.shared.currentUser?.uid == adminID {
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
