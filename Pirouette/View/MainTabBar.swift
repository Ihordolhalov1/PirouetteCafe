//
//  MainTabBar.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.01.2024.
//

import SwiftUI

struct MainTabBar: View {
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
            
            CartView(viewModel: CartViewModel())
                .tabItem {
                    VStack {
                        Image(systemName: "cart")
                        Text("Cart")
                    }
                }
            
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Account")
                    }
                }
            
        }
    }
}

#Preview {
    MainTabBar()
}
