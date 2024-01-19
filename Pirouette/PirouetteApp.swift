//
//  PirouetteApp.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 15.01.2024.
//

import SwiftUI

let screen = UIScreen.main.bounds // повертає розмір екрана поточного девайса

@main
struct PirouetteApp: App {
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
