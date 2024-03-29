//
//  ProductCell.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.01.2024.
//

import SwiftUI

struct ProductCell: View {
    var product: Product
    @State var uiImage = UIImage(systemName: "takeoutbag.and.cup.and.straw")!
    
    var body: some View {
        VStack {
            Image(uiImage: uiImage).resizable().scaledToFit()
            
            HStack {
                Text(product.title)
                Spacer()
                Text(stringPrice(price: product.price)).bold()
            }.padding(.horizontal, 4)
            
        }.frame(width: screen.width * 0.45, height: screen.width * 0.5, alignment: .leading)
            .background(.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 0)))
            .shadow(radius: 10)
            .onAppear {
                let imageName = self.product.id + "_mini"
                StorageService.shared.downloadProductImage(id: imageName) { result in
                    switch result {
                        
                    case .success(let data):
                        self.uiImage = UIImage(data: data)!
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
       

    }
}

#Preview {
    ProductCell(product: Product(id: "1", title: "Title1 Title1", price: 10.1, descript: "Description 1", isRecommended: false, isStarters: false, isMainDishes: false, isDesserts: false))
}
