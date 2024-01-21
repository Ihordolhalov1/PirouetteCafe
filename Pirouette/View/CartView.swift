//
//  CartView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.01.2024.
//

import SwiftUI

struct CartView: View {
    var viewModel: CartViewModel
    
    var body: some View {
        Text("Cart")
    }
}

#Preview {
    CartView(viewModel: CartViewModel())
}
