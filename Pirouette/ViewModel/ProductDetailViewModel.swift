//
//  ProductDetailViewModel.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 19.01.2024.
//

import Foundation
class ProductDetailViewModel: ObservableObject {
    
    @Published var product: Product
    @Published var sizes = ["Small", "Medium", "Ladge"]
    
    
    init(product: Product) {
        self.product = product
    }
    
    func getPrice(size: String) -> Double {
        var price: Double = 0
        switch size {
        case "Small": price = product.price
        case "Medium": price = product.price * 1.2
        case "Ladge": price = product.price * 1.5

        default:
            price = product.price
        }
        return price
    }
}
