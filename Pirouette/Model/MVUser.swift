//
//  MVUser.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 25.01.2024.
//

import Foundation
struct MVUser: Identifiable {
    var id: String
    var name: String
    var phone: String
    var address: String
    
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phone
        repres["address"] = self.address

        return repres
    }
    
}
