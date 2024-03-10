//
//  OrderStatus.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 28.01.2024.
//

import Foundation
enum OrderStatus: String, CaseIterable {
    case new = "New"
    case book = "Table booked"
    case cooking = "In process"
    case delivery = "In delivery"
    case completed = "Completed"
    case cancelled = "Cancelled"
}
