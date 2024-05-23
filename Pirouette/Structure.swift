//
//  Structure.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 20.05.2024.
//

/*
 Структура моделей:
 Product
  id: String
  title: String
  price: Double
  descript: String
  isRecommended: Bool
  isStarters: Bool
  isMainDishes: Bool
  isDesserts: Bool
 
 Position
     d: String
     product: Product
     count: Int
     var cost: Double {
         return product.price * Double(count)
     }
 
 Order
     id = UUID().uuidString
     userID: String
     positions = [Position]()
     date: Date
     status: String
     address: String
     dateToDeliver: Date
     var cost: Double {
         var sum = 0.0
         for pos in positions {
             sum += pos.cost
         }
         return sum
     }
 
 DetailedUser
     id: String
     name: String
     phone: String
     address: String
     token: String = deviceToken
 
 Методи:
 class AuthService
 func signUp(email: String, password: String, completion: @escaping (Result<User, Error>)
 func signIn(email: String, password: String, completion: @escaping (Result<User, Error>)
 func signOut()
 func resetPassword(email: String, completion: @escaping (Result<User, Error>)
 
 CommonServices
 func stringPrice (price: Double) -> String
 func dateToString(date: Date) -> String
 
 class DatabaseService
 func getPositions(by orderID: String, completion: @escaping (Result<[Position], Error>)
 func getOrders(by userID: String?, completion: @escaping (Result<[Order], Error>)
 func setOrder(order: Order, completion: @escaping (Result<Order, Error>)
 func setPositions(orderId: String, positions: [Position], completion: @escaping (Result<[Position], Error>)
 func setProfile(user: DetailedUser, completion: @escaping (Result<DetailedUser, Error>)
 func getProfile(by userID:String? = nil, completion: @escaping (Result<DetailedUser, Error>)
 func getProducts (completion: @escaping (Result<[Product], Error>)
 func updateToken()
 
 
 class StorageService
 func downloadProductImage(id: String, completion: @escaping(Result<Data, Error>)
 
 
 */
