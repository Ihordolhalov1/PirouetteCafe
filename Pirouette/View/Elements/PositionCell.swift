//
//  PositionCell.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 21.01.2024.
//

import SwiftUI

struct PositionCell: View {
    let position: Position
    
    var body: some View {
        HStack {
            Text(position.product.title)
                .fontWeight(.bold)
            Spacer()
            Text("\(position.count) pcs")
            Text(String(format: "%.2f", position.cost) + "€")
            
        }.padding(.horizontal)
        
    }
}

#Preview {
    PositionCell(position: Position(id: UUID().uuidString, product: Product(id: UUID().uuidString, title: "Title1 ", price: 5.10, descript: "Title 1 Disc"), count: 5))
}
