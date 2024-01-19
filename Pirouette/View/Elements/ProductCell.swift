//
//  ProductCell.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.01.2024.
//

import SwiftUI

struct ProductCell: View {
    var product: Product
    var body: some View {
        VStack {
            Image("pizza").resizable().scaledToFit()
            
            HStack {
                Text(product.title)
                Spacer()
                Text(String(product.price) + "€").bold()
            }.padding(.horizontal, 4)
            
        }.frame(width: screen.width * 0.45, height: screen.width * 0.45, alignment: .leading)
            .background(.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 0)))
            .shadow(radius: 10)

       

    }
}

#Preview {
    ProductCell(product: Product(id: "1", title: "Title1 Title1", imageUrl: "Url1", price: 10.1, descript: "Description 1"))
}
