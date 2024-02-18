//
//  ProductDetailViewModel.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 19.01.2024.
//

import Foundation
import SwiftUI

class ProductDetailViewModel: ObservableObject {
    
    @Published var product: Product
    @Published var sizes = ["Small", "Medium", "Ladge"]
    @Published var image = UIImage(systemName: "takeoutbag.and.cup.and.straw")!
    
    init(product: Product) {
        self.product = product
        getImage()
       
    }
    
    func getPrice(size: String) -> Double {
        var price: Double = 0
        switch size {
        case "Small": price = product.price
        case "Medium": price = product.price * 1.2
        case "Ladge": price = product.price * 1.5

        default:
            price = product.price
        }
        return price
    }
    
    func getImage() {
        StorageService.shared.downloadProductImage(id: product.id) { result in
            switch result {
                
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.image = image
                    print("IMAGE WAS CHANGES SUCCESSFULLY!!!")
                }
            case .failure(let error):
                print("ERROR OCCURED ON getImage()")
                print(error.localizedDescription)
            }
        }
    }
    
    
}
