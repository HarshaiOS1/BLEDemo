//
//  BLEDemoApp.swift
//  BLEDemo
//
//  Created by Krishnappa, Harsha on 24/05/2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct BLEDemoApp: App {
    var body: some Scene {
        WindowGroup {
            BLEListView(store: Store(initialState: BLEListReducer.State(), reducer: {
                BLEListReducer()
            }))
        }
    }
}
