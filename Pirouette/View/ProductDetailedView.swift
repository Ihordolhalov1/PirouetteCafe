//
//  ProductDetailedView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 19.01.2024.
//

import SwiftUI

struct ProductDetailedView: View {
    var product: Product
    
    var body: some View {
        Text(product.title)
    }
}

#Preview {
    ProductDetailedView(product: Product(id: "1", title: "Title1 Title1", imageUrl: "Url1", price: 10.1, descript: "Description 1"))
}
