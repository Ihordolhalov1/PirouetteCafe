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
    @State  private var isAuth = true
    @State  private var isTabViewShow = false
    
    
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
                        isTabViewShow.toggle()
                    } else {
                        print("Sign up button pressed")
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
          

            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("bg2").ignoresSafeArea())
        .padding()
        .animation(.easeInOut(duration: 0.3), value: isAuth)
        .fullScreenCover(isPresented: $isTabViewShow, content: {
            MainTabBar()
        })
    }
}

#Preview {
    AuthView()
}
