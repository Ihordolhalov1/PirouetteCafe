//
//  CartViewModel.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 21.01.2024.
//

import Foundation
class CartViewModel: ObservableObject {
    
    static let shared = CartViewModel()
    private init() { }
     
    @Published var positions = [Position]()
    @Published var countOfPositions = 0
    
    var cost: Double {
        var sum = 0.00
        for pos in positions {
            sum += pos.cost
        }
        return sum
    }
    
    
    func addPosition (position: Position) {
        if let existingPositionIndex = positions.firstIndex(where: { $0.product.id == position.product.id }) {
                // Позиция уже существует в корзине, поэтому увеличиваем количество
            
                positions[existingPositionIndex].count += position.count
            } else {
                // Позиция новая, добавляем её в корзину
                positions.append(position)
            }
    }
    
}
