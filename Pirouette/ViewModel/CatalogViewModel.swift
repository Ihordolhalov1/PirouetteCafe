//
//  CatalogViewModel.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 19.01.2024.
//

import Foundation

class CatalogViewModel: ObservableObject {
    
    static let shared = CatalogViewModel()
    
    @Published var products = [
        Product(id: "1", title: "Title1 Title1", price: 11.1, descript: "Description 1"),
        Product(id: "2", title: "Title2 Title2", price: 22.2, descript: "Description 2"),
        Product(id: "3", title: "Title3 Title3", price: 33.3, descript: "Description 3")
    ]
    @Published var pizzas = [
        Product(id: "1", title: "Pizza1 Title1", price: 11.1, descript: "Description 1"),
        Product(id: "2", title: "Pizza2 Title2", price: 22.2, descript: "Description 2"),
        Product(id: "3", title: "Pizza3 Title3", price: 33.3, descript: "Description 3")
    ]
    
    
    
    func getProducts () {
        DatabaseService.shared.getProducts { result in
            switch result {
            case .success(let products):
                self.pizzas = products
                print("УСПЕШНОЕ ПОЛУЧЕНИЕМ ПРОДУКТА С FB")
            case .failure(let error):
                print("ОШИБКА С ПОЛУЧЕНИЕМ ПРОДУКТА С FB")
                print(error.localizedDescription)
            }
        }
    }
    
    
}
