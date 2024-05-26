//
//  NetworkMonitor.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 24.05.2024.
//

import Network
import SwiftUI
import Combine

class NetworkMonitor: ObservableObject {
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global(qos: .background)
    
    @Published var isConnected: Bool = true
    
    init() {
        self.monitor = NWPathMonitor()
        self.monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        self.monitor.start(queue: queue)
    }
}
