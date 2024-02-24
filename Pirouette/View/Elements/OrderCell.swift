//
//  OrderCell.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 03.02.2024.
//

import SwiftUI

struct OrderCell: View {
    
    var order: Order

    var body: some View {
        HStack {
            Text(dateToString(date: order.date))
            Text(stringPrice(price: order.cost)).bold().frame(width: 100)
            Text("\(order.status)").frame(width: 120).foregroundColor(.green)
        }
    }
}

/*#Preview {
    OrderCell(order: Order(userID: "UserIS", date: Date(), status: "Status", address: "Address", dateToGet: Date()))
}*/
