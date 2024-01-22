//
//  ProductDetailedView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 19.01.2024.
//

import SwiftUI

struct ProductDetailedView: View {
    var viewModel: ProductDetailViewModel
    @State var size = "Small"
    @State var count = 1
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading){
            Image("pizza").resizable().scaledToFit()
            
            HStack{
                Text(viewModel.product.title).font(.title2.bold())
                Spacer()
                //        Text("\(viewModel.product.price)" + "€").font(.title2)
                Text(String(format: "%.2f", viewModel.getPrice(size: size)) + "€").font(.title2)
            }.padding(.horizontal)
        
            
            HStack {
                Stepper("Amount: " + "\(self.count)", value: $count, in: 1...10)
            }.padding(.horizontal)
          
            
            Text(viewModel.product.descript)
                .padding(.horizontal)
                .padding(.vertical, 1)
            
   
            
            
            Picker("Size", selection: $size) {
                ForEach(viewModel.sizes, id: \.self) {
                    item in
                    Text(item)
                }
                
            } .pickerStyle(.segmented).padding()
            
            
          
            }

        
        Button("Add to cart") {
            
            var position = Position(id: UUID().uuidString, product: viewModel.product, count: self.count)
            position.product.price = viewModel.getPrice(size: size) //міняємо ціну на ту, яка є відповідно до розміру піци
            CartViewModel.shared.addPosition(position: position)
            presentationMode.wrappedValue.dismiss()
            
        }
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(12)
            .padding(8)
            .font(.title3.bold())
            .foregroundColor(.black)
     Spacer()
        
    
        
        
        }
   
}

#Preview {
    ProductDetailedView(viewModel: ProductDetailViewModel(product: Product(id: "1", title: "Title1", imageUrl: "NoUrl", price: 11.1, descript: "Descr1")))
}
