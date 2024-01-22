//
//  CartView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.01.2024.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel: CartViewModel
    
    var body: some View {
        VStack {
            List(viewModel.positions) { position in
                PositionCell(position: position)
                    .swipeActions {
                        Button {
                            viewModel.positions.removeAll() {
                                pos in
                                pos.id == position.id
                            }
                        } label: {
                            Text("Delete")
                        }.tint(.red)
                    }
            }.listStyle(.plain)
                .navigationTitle("Cart")
            
            HStack{
                Text("Total: ").fontWeight(.bold)
                Spacer()
                Text((String(format: "%.2f", self.viewModel.cost) + "€")).fontWeight(.bold)
            }.padding()
            
            HStack(spacing: 25) {
                Button(action: {}, label: {
                    Text("Clear")
                }).padding()
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .cornerRadius(12)
                    .padding(8)
                    .font(.title3.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Accept")
                })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(12)
                    .padding(8)
                    .font(.title3.bold())
                    .foregroundColor(.black)
                    
            }.padding()
            
            
        }
    }
}

#Preview {
    CartView(viewModel: CartViewModel.shared)
}
