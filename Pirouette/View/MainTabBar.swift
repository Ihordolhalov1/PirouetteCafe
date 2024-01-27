//
//  MainTabBar.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.01.2024.
//

import SwiftUI

struct MainTabBar: View {
    var viewModel: MainTabBarViewModel
    
    var body: some View {
        TabView {
            
            NavigationView {
                CatalogView()
            }
                .tabItem {
                    VStack {
                        Image(systemName: "menucard")
                        Text("Catalog")
                    }
                }
            
            CartView(viewModel: CartViewModel.shared)
                .tabItem {
                    VStack {
                        Image(systemName: "cart")
                        Text("Cart")
                    }
                }
            
            ProfileView(viewModel: ProfileViewModel(profile: MVUser(id: viewModel.user.uid, name: "", phone: 0, address: "")))
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Account")
                    }
                }
            
        }
    }
}



