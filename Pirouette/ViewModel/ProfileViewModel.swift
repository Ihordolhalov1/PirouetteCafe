//
//  ProfileViewModel.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 26.01.2024.
//

import Foundation
import FirebaseStorage

class ProfileViewModel: ObservableObject {
    
    @Published var profile: DetailedUser
    @Published var orders: [Order] = [Order]()
    
    init(profile: DetailedUser) {
        self.profile = profile
    }
    
    func getOrders() {
        DatabaseService.shared.getOrders(by: AuthService.shared.currentUser!.uid) { result in
      //  DatabaseService.shared.getOrders(by: profile.id) { result in
            switch result {
            case .success (let orders):
                self.orders = orders
                
                for (index, order) in self.orders.enumerated() {
                    DatabaseService.shared.getPositions(by: order.id) { result in
                        switch result {
                        case .success(let positions):
                            self.orders[index].positions = positions
                        case .failure(let error):
                            print (error.localizedDescription)
                        }
                    }
                }
                print("Відпрацював метод getOrders з ProfileViewModel")

                print( "Total amount of orders: \(orders.count)")
            case .failure (let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func setProfile() {
        DatabaseService.shared.setProfile(user: self.profile) { result in
            switch result {
            case .success(_):
                print("Відпрацював метод setProfile з ProfileViewModel")
                print("token is ", deviceToken)
            case .failure(let error):
                print ("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func getProfile() {
        DatabaseService.shared.getProfile { result in
            switch result {
                
            case .success(let user):
                print("Відпрацював метод getProfile з ProfileViewModel")

                self .profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
