//
//  CatalogView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.01.2024.
//

import SwiftUI

struct CatalogView: View {
    
    let layout = [GridItem(.adaptive(minimum: screen.width / 3))]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            Section("Popular") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layout) {
                        ForEach(CatalogViewModel.shared.products, id: \.id) {
                            item in
                            NavigationLink {
                                let viewModel = ProductDetailViewModel(product: item)
                                ProductDetailedView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundStyle(.black)
                            }
                           
                        }
                    } .padding()
                }
            }
            
            
            Section("Pizzas") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layout) {
                        ForEach(CatalogViewModel.shared.pizzas, id: \.id) {
                            item in
                            
                            NavigationLink {
                                let viewModel = ProductDetailViewModel(product: item)
                                ProductDetailedView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundStyle(.black)
                            }
                        }
                    } .padding()
                }
            }
            
        }.navigationTitle("Catalog")
    }
}

#Preview {
    CatalogView()
}
