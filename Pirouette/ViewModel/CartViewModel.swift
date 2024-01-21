//
//  CartViewModel.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 21.01.2024.
//

import Foundation
class CartViewModel: ObservableObject {
     
    @Published var positions = [Position]()
    
    func addPosition (position: Position) {
        self.positions.append(position)
    }
    
}
