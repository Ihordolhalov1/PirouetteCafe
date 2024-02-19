//
//  ProductDetailedView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 19.01.2024.
//

import SwiftUI

struct ProductDetailedView: View {
    @State var viewModel: ProductDetailViewModel
    @State var size = "Small"
    @State var count = 1
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                
                Image(uiImage: viewModel.image).resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                //      .padding(.top, 1)
                //.scaledToFit()
                //  .frame(width: 500)
                Spacer()
                HStack{
                    Text(viewModel.product.title).font(.title2.bold())
                    Spacer()
                    //        Text("\(viewModel.product.price)" + "€").font(.title2)
                    Text(stringPrice(price:viewModel.getPrice(size: size)) ).font(.title2)
                }.padding(.horizontal)
                
                
                HStack {
                    Stepper("Amount: " + "\(self.count)", value: $count, in: 1...50)
                }.padding(.horizontal).font(.title3.bold())
                
                
                Text(viewModel.product.descript)
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical, 1)
                
                
                
                
                /*    Picker("Size", selection: $size) {
                 ForEach(viewModel.sizes, id: \.self) {
                 item in
                 Text(item)
                 }
                 
                 } .pickerStyle(.segmented).padding() */
                
                
                
                
            } //.ignoresSafeArea(.all)
        }
            Spacer()
            
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
           // .padding(8)
            .font(.title3.bold())
            .foregroundColor(.black)
 //       } .padding(.bottom,10)
           

     Spacer()
        
    
        
        
        }
   
}

#Preview {
    ProductDetailedView(viewModel: ProductDetailViewModel(product: Product(id: "1", title: "Title1", price: 11.1, descript: "Savor the mouthwatering delight of our expertly fried salmon served alongside a vibrant array of fresh, seasonal vegetables. Enjoy the perfect balance of succulent salmon and crisp, flavorful vegetables, creating a dish that's as satisfying to the palate as it is nourishing for the soul. Dive into a symphony of flavors with our fried salmon with vegetables.")))
}
