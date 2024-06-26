//
//  Order.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 27.01.2024.
//

import Foundation
import FirebaseFirestore

struct Order {
    var id = UUID().uuidString
    var userID: String
    var positions = [Position]()
    var date: Date
    var status: String
    var address: String
    var dateToDeliver: Date
  //  var clientToken: String
    
    var cost: Double {
        var sum = 0.0
        for pos in positions {
            sum += pos.cost
        }
        return sum
    }
    
    var representation: [String: Any] {
        
        var repres = [String: Any]()
        repres["id"] = id
        repres["userID"] = userID
        repres["date"] = Timestamp(date: date)
        repres["status"] = status
        repres["address"] = address
        repres["dateToGet"] = Timestamp(date: dateToDeliver)
 //       repres["clientToken"] = clientToken
   //     repres ["countOfPerson"] = countOfPerson
        
        return repres
    }
    
    init(id: String = UUID().uuidString,
         userID: String,
         positions: [Position] = [Position](),
         date: Date,
         status: String, address: String, dateToGet: Date) {
        self.id = id
        self.userID = userID
        self.positions = positions
        self.date = date
        self.status = status
        self.address = address
        self.dateToDeliver = dateToGet
    //    self.clientToken = clientToken
    //    self.countOfPerson = countOfPerson
    }
    
    init? (doc: QueryDocumentSnapshot) {
        let data = doc.data()
        guard let id = data["id"] as? String else { return nil}
        guard let userID = data["userID"] as? String else { return nil }
        guard let date = data[ "date"] as? Timestamp else { return nil }
        guard let status = data["status"] as? String else { return nil }
        guard let address = data["address"] as? String else { return nil }
        guard let dateToGet = data["dateToGet"] as? Timestamp else { return nil }
    //    guard let clientToken = data["clientToken"] as? String else { return nil }
     //   guard let countOfPerson = data["countOfPerson"] as? Int else { return nil }

        self.id = id
        self.userID = userID
        self.date = date.dateValue()
        self.status = status
        self.address = address
        self.dateToDeliver = dateToGet.dateValue()
   //     self.clientToken = clientToken
   //     self.countOfPerson = countOfPerson
    }
    
}
