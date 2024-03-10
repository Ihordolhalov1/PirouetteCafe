//
//  OrderCell.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 03.02.2024.
//

import SwiftUI

struct OrderCell: View {
    @State var date: Date
   // @State var status: String
    
    var order: Order

    var body: some View {
        HStack {
            Text(dateToString(date: date)).lineLimit(1).padding(.trailing)        
            Text(stringPrice(price: order.cost)).bold().lineLimit(1)
            Spacer()
            Text("\(order.status)").foregroundColor(.green).lineLimit(1)
           // frame(width: 120).
        }
    }
}

#Preview {
    OrderCell(date: Date(), order: Order(userID: "UserIS", date: Date(), status: "Status", address: "Address", dateToGet: Date()))
}
