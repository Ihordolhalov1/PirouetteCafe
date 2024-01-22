//
//  ProfileView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.01.2024.
//

import SwiftUI

struct ProfileView: View {
    @State var isAvaAlertPresented = false
    @State var isQuitAlertPresented = false
    @State var isAuthViewPresented = false

    
    var body: some View {
    //    ScrollView {

            VStack(alignment: .leading) {
                HStack (spacing: 10){
                    Image(systemName: "person")
                        .padding(.horizontal)
                        .onTapGesture {
                            isAvaAlertPresented.toggle()
                        }
                        .confirmationDialog("Photo of the user", isPresented: $isAvaAlertPresented) {
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("Photo gallery")
                            })
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("Camera")
                            })
                            
                        }
                    VStack(alignment: .leading) {
                        Text("Person name").bold().font(.title2)
                        Text("+380671111111")
                    }
                }.padding(.vertical)
                Text("Delivery address:").bold()
                Text("Address")
                
                // Таблица с заказами
                List {
                 Text ("Order 1")
                 Text ("Order 2")
                 Text ("Order 3")
                 }.listStyle(.plain)
                
                 Button(action: {
                     isQuitAlertPresented.toggle()
                     
                 }, label: {
                 Text("Log out")
                 .padding()
                 .frame(maxWidth: .infinity)
                 .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
                 .cornerRadius(12)
                 .padding(8)
                 .font(.title3.bold())
                 .foregroundColor(.black)
                 }
                 
                 ).confirmationDialog("Are you really want to quit?", isPresented: $isQuitAlertPresented) {
                     Button(action: {
                         isAuthViewPresented.toggle()
                     }, label: {
                         Text("Yes, quit!")
                     })
                 }

                
            } .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .fullScreenCover(isPresented: $isAuthViewPresented, content: {
                    AuthView()
                })
        }
    }
//}

#Preview {
    ProfileView()
}
