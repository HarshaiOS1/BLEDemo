//
//  BLEListView.swift
//  BLEDemo
//
//  Created by Krishnappa, Harsha on 24/05/2024.
//

import SwiftUI

struct BLEListView: View {
    var body: some View {
        VStack {
            Image(systemName: "network")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button {
                BLEManager().startCentralManger()
            } label: {
                Text("Get BLE devices")
            }
            .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
        }
        .padding()
    }
}

#Preview {
    BLEListView()
}
