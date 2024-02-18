//
//  OrderStatus.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 28.01.2024.
//

import Foundation
enum OrderStatus: String, CaseIterable {
    case new = "new"
    case cooking = "in process"
    case delivery = "in delivery"
    case completed = "Completed"
    case cancelled = "cancelled"
}
