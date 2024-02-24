//
//  AdminOrdersViewModel.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 04.02.2024.
//

import Foundation

class AdminOrdersViewModel: ObservableObject {
    
    @Published var orders = [Order]()
    var currentOrder = Order(userID: "", date: Date(), status: "", address: "Restaurant", dateToGet: Date())
    
    func getOrders() {
        DatabaseService.shared.getOrders(by: nil) { result in
            switch result {
            case .success (let orders):
                self.orders = orders
                
                for (index, order) in self.orders.enumerated() {
                    DatabaseService.shared.getPositions(by: order.id) { result in
                        switch result {
                        case .success(let positions):
                            self.orders[index].positions = positions
                        case .failure(let error):
                            print (error.localizedDescription)
                        }
                    }
                }
                
            case .failure (let error):
                print(error.localizedDescription)
            }
        }
    }
}
