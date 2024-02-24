//
//  OrderView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 04.02.2024.
//

import SwiftUI

struct OrderView: View {
    @StateObject var viewModel: OrderViewModel
    
    var statuses = ["new", "in process", "in delivery", "Completed", "cancelled"]
  
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text("\(viewModel.user.name)").font(.title3).bold()
            Text("\(viewModel.user.phone)").bold()
            Text("\(viewModel.user.address)")
            
            Picker(selection: $viewModel.order.status) {
                ForEach(statuses, id: \.self) { status in
                    Text(status)
                }
            } label: {
                Text("Status")
            } .pickerStyle(.segmented)
            .onChange(of: viewModel.order.status) { oldValue, newValue in //изменение статуса
                DatabaseService.shared.setOrder(order: viewModel.order) { result in
                    switch result {
                    case .success (let order):
                    print (order.status)
                    case .failure (let error):
                    print(error.localizedDescription)
                    }
                }
            }
        
            
            List{
                ForEach(viewModel.order.positions, id: \.id) { position in
                    PositionCell(position: position)
                }
            }
            Text(stringPrice(price:viewModel.order.cost)).bold()
            
        }.padding()
            .onAppear {
                viewModel.getUserData()
            }
    }
}

#Preview {
    OrderView(viewModel: OrderViewModel(order: Order(userID: "userID", date: Date(), status: "Status", address: "Address", dateToGet: Date())))
}
