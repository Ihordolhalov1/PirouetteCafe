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
        Product(id: "1", title: "Favourite dish 1", price: 0.0, descript: "Description 1"),
        Product(id: "2", title: "Favourite dish 2", price: 0.0, descript: "Description 2"),
        Product(id: "3", title: "Favourite dish 3", price: 0.0, descript: "Description 3")
    ]
    @Published var delishious = [
        Product(id: "1", title: "Delishious Title1", price: 0.0, descript: "Description 1"),
        Product(id: "2", title: "Delishious Title2", price: 0.0, descript: "Description 2"),
        Product(id: "3", title: "Delishious Title3", price: 0.0, descript: "Description 3")
    ]
    
    
    
    func getProducts () {
        DatabaseService.shared.getProducts { result in
            switch result {
            case .success(let products):
                self.delishious = products
                print("УСПЕШНОЕ ПОЛУЧЕНИЕМ ПРОДУКТА С FB")
            case .failure(let error):
                print("ОШИБКА С ПОЛУЧЕНИЕМ ПРОДУКТА С FB")
                print(error.localizedDescription)
            }
        }
    }
    
    
}
