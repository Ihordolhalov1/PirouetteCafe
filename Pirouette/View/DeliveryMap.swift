//
//  DeliveryMap.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 23.05.2024.
//

import SwiftUI

struct DeliveryMap: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var hideText = false
    
    var body: some View {
        Text("Our delivery area").font(.title).bold().padding()
        Image("local map")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(scale)
                    .offset(x: offset.width, y: offset.height)
                    .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            self.offset = CGSize(width: self.lastOffset.width + value.translation.width, height: self.lastOffset.height + value.translation.height)
                                            hideText = true
                                        }
                                        .onEnded { value in
                                            self.lastOffset = self.offset
                                        }
                                )
             
                    .gesture(
                                    MagnificationGesture()
                                        .onChanged { value in
                                            self.scale = self.lastScale * value
                                            hideText = true

                                        }
                                        .onEnded { value in
                                            self.lastScale = self.scale
                                        }
                                )
                    .padding()
        if !hideText {
            Text("We cover only this area with our own delivery. Sorry for the inconvenience.").lineLimit(nil).padding()
        }
        Spacer()
        
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            CustomButton (text: "OK", opacity: 1)
        })
           
                }
}

#Preview {
    DeliveryMap()
}
