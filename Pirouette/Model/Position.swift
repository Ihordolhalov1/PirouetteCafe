//
//  Position.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 21.01.2024.
//

import Foundation
struct Position {
    var id: String
    var product: Product
    var count: Int
    
    var cost: Double {
        return product.price * Double(count)
    }
}
