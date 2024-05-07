//
//  AdminOrderView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 04.02.2024.
//

import SwiftUI

struct AdminOrderView: View {
    
    @StateObject var viewModel = AdminOrdersViewModel()
    @State var isOrderViewShow = false
    @State var isAuthViewShow = false
    @State private var showProfileView = true
 //   @StateObject var profileViewModel: ProfileViewModel


    // @State private var isAddProductViewShow = false
    
    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect() // 300 seconds = 5 minutes

    var body: some View {
        
        VStack {
            
            HStack {
                
                Button {
                    viewModel.getOrders()
                } label: {
                    Text("Reload")
                }.foregroundColor(.green).buttonStyle(.bordered)
                
                Spacer()
                
            /*    Button {
                    isAddProductViewShow.toggle()
                } label: {
                    Text("Add a dish")
                }.foregroundColor(.orange).buttonStyle(.bordered)
                
                Spacer() */
                
                Button {
                    AuthService.shared.signOut()
                    isAuthViewShow.toggle()
                } label: {
                    Text("Exit")
                }.foregroundColor(.red).buttonStyle(.bordered)
                
                
            }.padding()
           
            
            
            List {
                ForEach(viewModel.orders.sorted(by: { $0.date > $1.date }),  id:\.id) {order in
                    OrderCell(date: order.dateToDeliver, order: order)
                        .onTapGesture {
                            viewModel.currentOrder = order
                            isOrderViewShow.toggle()
                        }
                }
                
                
            }.listStyle(.plain)
                .refreshable {
                    viewModel.getOrders()
                }
                .onAppear {
                    viewModel.getOrders()
                }
                .onReceive(timer) { _ in
                           viewModel.getOrders() // Reload orders every 1 minutes
                       }
                .sheet(isPresented: $isOrderViewShow, onDismiss: {
                    viewModel.getOrders() // Reload orders when OrderView is dismissed
                }) {
                    let orderViewModel = OrderViewModel(order: viewModel.currentOrder)
                    OrderView(viewModel: orderViewModel)
                }

        } .fullScreenCover(isPresented: $isAuthViewShow, content: {
            AuthView()
        })
        // .sheet(isPresented: $isAddProductViewShow, content: { AddProductView() })
    }
}

#Preview {
    AdminOrderView()
}
