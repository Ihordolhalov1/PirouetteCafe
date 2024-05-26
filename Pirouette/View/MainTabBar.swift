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
    
    @StateObject private var networkMonitor = NetworkMonitor()
    @State private var showNetworkAlert = false

    
    
    var body: some View {
        TabView(selection: $selection) {
            
            NavigationView {

                CatalogView(viewModel: CatalogViewModel.shared)
                
            }
                .tabItem {
                    VStack {
                        Image(systemName: "menucard")
                        Text("Catalog")
                    }
                }
                .onAppear() {
                    CatalogViewModel.shared.getProducts()
                    if !networkMonitor.isConnected {
                        showNetworkAlert = true
                    }

                }
                .alert(isPresented: $showNetworkAlert) {
                           Alert(
                               title: Text("No Internet Connection"),
                               message: Text("Please check your internet connection."),
                               dismissButton: .default(Text("OK"))
                           )
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
                    print("ЗАйшли в корзину")
                           // Переключаемся на вкладку CatalogView после некоторой задержки
                    if isFirstLanch {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isFirstLanch = false
                            selection = 3
                            print("ЗАйшли в профайл")


                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                selection = 2
                                print("ЗАйшли в каталог")

                            }
                        }
                    }
                       }
                
            
            ProfileView(viewModel: ProfileViewModel(profile: DetailedUser(id: viewModel.user.uid, name: "", phone: "", address: "", token: deviceToken)))
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Account")
                    }
                }
                .tag(3)
               
            MapView()
                .tabItem {
                    VStack {
                        Image(systemName: "map.circle")
                        Text("Contact")

                    }
                }
            
        } 
        
    }
}



