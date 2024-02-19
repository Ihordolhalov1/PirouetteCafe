//
//  CommonServices.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.02.2024.
//

import Foundation

func stringPrice (price: Double) -> String {
    
    return String(format: "%.2f", price) + "€"
}

func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
    let formattedDate = dateFormatter.string(from: date)
    return formattedDate
}
