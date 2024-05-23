//
//  CatalogView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.01.2024.
//

import SwiftUI

struct CatalogView: View {
    let layout = [GridItem(.adaptive(minimum: screen.width / 3))]
    @StateObject var viewModel = CatalogViewModel()

    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {

            Section(header:
                            Text("Recommended by Chef")
                                .font(.headline)
                                .bold()
                        )  {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layout) {
                        ForEach(viewModel.recommended, id: \.id) {
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
            
            
            Section(header:
                            Text("Starters")
                                .font(.headline)
                                .bold()
                        )  {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layout) {
                        ForEach(viewModel.starters, id: \.id) {
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
            
            Section(header:
                            Text("Main dishes")
                                .font(.headline)
                                .bold()
                        )   {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layout) {
                        ForEach(viewModel.mainDishes, id: \.id) {
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
            
            Section(header:
                            Text("Desserts")
                                .font(.headline)
                                .bold()
                        )   {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layout) {
                        ForEach(viewModel.desserts, id: \.id) {
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
            
            
        }
    }
}

#Preview {
    CatalogView()
}
