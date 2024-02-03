//
//  ProfileViewModel.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 26.01.2024.
//

import Foundation
import FirebaseStorage

class ProfileViewModel: ObservableObject {
    
    @Published var profile: MVUser
    @Published var orders: [Order] = [Order]()
    
    init(profile: MVUser) {
        self.profile = profile
    }
    
    func getOrders() {
        DatabaseService.shared.getOrders(by: AuthService.shared.currentUser!.accessibilityHint) { result in
            
            switch result {
            case .success (let orders):
                self.orders = orders
                print( "Total amount of orders: \(orders.count)")
            case .failure (let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setProfile() {
        DatabaseService.shared.setProfile(user: self.profile) { result in
            switch result {
            case .success(let user):
                print(user.name)
            case .failure(let error):
                print ("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func getProfile() {
        DatabaseService.shared.getProfile { result in
            switch result {
                
            case .success(let user):
                self .profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
