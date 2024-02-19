//
//  CustomButton.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.02.2024.
//

import SwiftUI

struct CustomButton: View {
    let text: String
    let opacity: Double
    var body: some View {
            Text(text)
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
            .opacity(opacity)
            .cornerRadius(12)
            .padding(8)
            .font(.title3.bold())
        .foregroundColor(.black)

        
    
    }
}

#Preview {
    CustomButton(text: "Lock", opacity: 1.0)
}
