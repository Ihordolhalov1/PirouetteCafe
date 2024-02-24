//
//  ProfileView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.01.2024.
//

import SwiftUI

struct ProfileView: View {
    @State var isQuitAlertPresented = false
    @State var isAuthViewPresented = false
    
    @StateObject var viewModel: ProfileViewModel



    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                    HStack {
                        Text("Name:")
                        TextField("Name ", text: $viewModel.profile.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: viewModel.profile.name) {
                                viewModel.setProfile()
                            }
                    }

                        HStack {
                            Text("Phone: ")
                            TextField("+49 176 12345678", text: $viewModel.profile.phone)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: viewModel.profile.phone) {
                                    viewModel.setProfile()
                                }
                        }
                    
                        Text("Delivery address:")
                        TextField("Address", text: $viewModel.profile.address)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: viewModel.profile.address) {
                                viewModel.setProfile()
                                
                            }
                }.padding()
             

                
                // Таблица с заказами
                
                List {
                    if viewModel.orders.count == 0 {
                        Text ("Here will be your orders")
                    } else {
                        ForEach(viewModel.orders, id: \.id) { order in
                            OrderCell(order: order)
                        }
                    }
                 }.listStyle(.plain)
                
                 Button(action: {
                     isQuitAlertPresented.toggle()
                     
                 }, label: {
                     CustomButton(text: "Log out", opacity: 1.0)
                 }
                 
                 ).confirmationDialog("Are you really want to quit?", isPresented: $isQuitAlertPresented) {
                     Button(action: {
                         isAuthViewPresented.toggle()
                     }, label: {
                         Text("Yes, quit!")
                     })
                 }

                
            } .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding()
                .fullScreenCover(isPresented: $isAuthViewPresented) {
                    AuthView()
                }
                .onSubmit {
                    viewModel.setProfile()
                }
                .onAppear {
                    self.viewModel.getProfile()
                    self.viewModel.getOrders()
                }
        }
    }
//}

#Preview {
    ProfileView(viewModel: ProfileViewModel(profile: MVUser(id: "1", name: "Name", phone: "+49 123 0672351537", address: "Address")))
}
