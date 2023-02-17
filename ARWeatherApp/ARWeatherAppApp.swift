//
//  ARWeatherAppApp.swift
//  ARWeatherApp
//
//  Created by Noura Mohammad Althrowi on 23/07/1444 AH.
//

import SwiftUI

@main
struct ARWeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ARViewController.shared)
        }
    }
}
