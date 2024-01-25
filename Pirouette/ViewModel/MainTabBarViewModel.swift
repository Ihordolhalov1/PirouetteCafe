//
//  MainTabBarViewModel.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 25.01.2024.
//

import Foundation
import FirebaseAuth

class MainTabBarViewModel: ObservableObject {
    @Published var user: User
    init(user: User) {
        self.user = user
    }
}
