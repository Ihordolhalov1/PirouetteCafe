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
    // @State private var isAddProductViewShow = false
    
    
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
                ForEach(viewModel.orders,  id:\.id) {order in
                    OrderCell(order: order)
                        .onTapGesture {
                            viewModel.currentOrder = order
                            isOrderViewShow.toggle()
                        }
                }
            }.listStyle(.plain)
                .onAppear {
                    viewModel.getOrders()
                }
                .sheet(isPresented: $isOrderViewShow) {
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
