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
            Text(dateToString(date: order.date)).lineLimit(1)
            Spacer()
            Text(stringPrice(price: order.cost)).bold().lineLimit(1)
            Spacer()
            //.frame(width: 100)
            Text("\(order.status)").foregroundColor(.green).lineLimit(1)
           // frame(width: 120).
        }
    }
}

#Preview {
    OrderCell(order: Order(userID: "UserIS", date: Date(), status: "Status", address: "Address", dateToGet: Date()))
}
