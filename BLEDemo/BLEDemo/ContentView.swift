//
//  ContentView.swift
//  BLEDemo
//
//  Created by Krishnappa, Harsha on 24/05/2024.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "􀤆")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button {
                
            } label: {
                Text("Get BLE devices")
            }
            .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
