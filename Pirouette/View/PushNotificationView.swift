//
//  PushNotificationView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 01.05.2024.
//

import SwiftUI

struct PushNotificationView: View {
    var message: String
    var title: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Push Notification Received!")
                .font(.headline)
                .padding()
            Text(title)
                .font(.headline)
            Text(message)
                .padding()
            
            Button("Close") {
                dismiss()
                print("Close button pressed")
                        }
            .padding()

        }
    }
}

#Preview {
    PushNotificationView(message: "Mesage", title: "Title")
}
