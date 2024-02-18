//
//  AddProductView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 12.02.2024.
//

import SwiftUI

struct AddProductView: View {
    @State private var showImagePicker = false
    @State private var image = UIImage(systemName: "takeoutbag.and.cup.and.straw")!
    @State private var title: String = ""
    @State private var descript: String = ""
    @State private var price: Double = 0.00
    
    var body: some View {
        VStack{
            Text("Add a dish")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Spacer()
            
            Image(uiImage: image)
                .resizable()
                .frame(width: 250, height: 250, alignment: .center)
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    showImagePicker.toggle()
                    
                }
            
            TextField("Name: ", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                Text("Price, €")
                    .foregroundColor(.gray)
                TextField("Price, €", value: $price, format: .number)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // Optional styling
            }
            
            ZStack(alignment: .topLeading) {
                       
                        TextEditor(text: $descript)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                if descript.isEmpty {
                    Text("Enter description here")
                        .foregroundColor(.gray)
                  
                }
                    }
                    .padding()
                    .border(Color.gray, width: 1)
                
            
         //   TextEditor("Descriprion: ", text: $descript)
         //       .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                //SAVE b
            }, label: {
                Text("Save")
            })
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(12)
            .padding(8)
            .font(.title3.bold())
            .foregroundColor(.black)
           
        }
        .padding()
        .sheet(isPresented: $showImagePicker, content: {
            //ImagePicker
           // PhotoPicker(selectedImage: $image)
        })
    }
}

#Preview {
    AddProductView()
}
