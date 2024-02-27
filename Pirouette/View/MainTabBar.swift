//
//  MainTabBar.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.01.2024.
//

import SwiftUI

struct MainTabBar: View {
    var viewModel: MainTabBarViewModel
   @State var count = 0
    @State var selection = 1
    @State private var isFirstLanch = true //Нужен чтоб отследить что запуск приложения первый раз и нужно активировать CartView перед CatalogView чтоб заработал счетчик товара в корзине
    
    var body: some View {
        TabView(selection: $selection) {
            
            NavigationView {

                CatalogView()
                
            }
                .tabItem {
                    VStack {
                        Image(systemName: "menucard")
                        Text("Catalog")
                    }
                }
                .tag(2)
            
            CartView(viewModel: CartViewModel.shared, numberOfDishes: $count)
                .tabItem {
                    VStack {
                        Image(systemName: "cart")
                        Text("Cart")
                    

                    }
                }
                .tag(1)
                .badge(count)
                .onAppear {
                           // Переключаемся на вкладку CatalogView после некоторой задержки
                    if isFirstLanch {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isFirstLanch = false
                            selection = 2
                        }
                    }
                       }
            
            ProfileView(viewModel: ProfileViewModel(profile: MVUser(id: viewModel.user.uid, name: "", phone: "", address: "")))
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Account")
                    }
                }
                .tag(3)
            
        } 
      
    }
}



