//
//  CatalogViewModel.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 19.01.2024.
//

import Foundation

class CatalogViewModel: ObservableObject {
    
    static let shared = CatalogViewModel()
    
    @Published var allProducts = [Product]()
    
    @Published var recommended = [Product]()
    /*[
        Product(id: "1", title: "recommended dish 1", price: 0.0, descript: "Description 1", isRecommended: false),
        Product(id: "2", title: "recommended dish 2", price: 0.0, descript: "Description 2", isRecommended: false),
    ]*/
    @Published var starters = [Product]()
     
    @Published var mainDishes = [Product]()
   
    @Published var desserts = [Product]()
    
    func getProducts () {
        DatabaseService.shared.getProducts { result in
            switch result {
            case .success(let products):
                self.allProducts = products
                print("УСПЕШНОЕ ПОЛУЧЕНИЕМ ПРОДУКТА С FB")
                
                self.recommended.removeAll()
                self.starters.removeAll()
                self.mainDishes.removeAll()
                self.desserts.removeAll()
                
                for product in products {
                    if product.isRecommended {
                        self.recommended.append(product)
                        print("ДОДАЮ РЕКОМЕНДОВАНОЕ")
                    }
                    if product.isStarters {
                        self.starters.append(product)
                        print("ДОДАЮ Starters")
                    }
                    if product.isMainDishes {
                        self.mainDishes.append(product)
                        print("ДОДАЮ mainDishes")
                    }
                    if product.isDesserts {
                        self.desserts.append(product)
                        print("ДОДАЮ desserts")
                    }
                    
                }
                
            case .failure(let error):
                print("ОШИБКА С ПОЛУЧЕНИЕМ ПРОДУКТА С FB")
                print(error.localizedDescription)
            }
        }
        
        
        
        
    }
   
    
}
