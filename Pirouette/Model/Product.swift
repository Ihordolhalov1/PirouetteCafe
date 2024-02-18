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
    
    //var ordersCount: Int
    //var isRecommend: Bool
    
    
    var representation: [String: Any] {
        var repres = [String:Any]()
        repres ["id"] = self.id
        repres ["title"] = self.title
        repres["price"] = self.price
        repres ["descript"] = self.descript
        return repres
    }
    
    internal init (id: String, title: String, price: Double, descript: String) {
        self.id = id
        self.title = title
        self.price = price
        self.descript = descript
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let price = data["price"] as? Double else { return nil }
        guard let descript = data["descript"] as? String else { return nil }

        
        self.id = id
        self.title = title
        self.price = price
        self.descript = descript
    }
    
}
