//
//  Product.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.01.2024.
//

import Foundation
import FirebaseFirestore

struct Product {
    var id: String
    var title: String
    var price: Double
    var descript: String
    var isRecommended: Bool
    var isStarters: Bool
    var isMainDishes: Bool
    var isDesserts: Bool
    

    
    
    var representation: [String: Any] {
        var repres = [String:Any]()
        repres ["id"] = self.id
        repres ["title"] = self.title
        repres["price"] = self.price
        repres ["descript"] = self.descript
        repres["recommended"] = self.isRecommended
        repres["starter"] = self.isStarters
        repres["maindish"] = self.isMainDishes
        repres["dessert"] = self.isDesserts
        return repres
    }
    
    internal init (id: String, title: String, price: Double, descript: String, isRecommended: Bool, isStarters: Bool, isMainDishes: Bool, isDesserts: Bool) {
        self.id = id
        self.title = title
        self.price = price
        self.descript = descript
        self.isRecommended = isRecommended
        self.isStarters = isStarters
        self.isMainDishes = isMainDishes
        self.isDesserts = isDesserts
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let price = data["price"] as? Double else { return nil }
        guard let descript = data["descript"] as? String else { return nil }
        guard let isRecommended = data["recommended"] as? Bool else { return nil }
        guard let isStarters = data["starter"] as? Bool else { return nil }
        guard let isMainDishes = data["maindish"] as? Bool else { return nil }
        guard let isDesserts = data["dessert"] as? Bool else { return nil }


        
        self.id = id
        self.title = title
        self.price = price
        self.descript = descript
        self.isRecommended = isRecommended
        self.isStarters = isStarters
        self.isMainDishes = isMainDishes
        self.isDesserts = isDesserts
    }
    
}
