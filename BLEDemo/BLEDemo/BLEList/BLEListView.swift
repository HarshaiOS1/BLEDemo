//
//  BLEListView.swift
//  BLEDemo
//
//  Created by Krishnappa, Harsha on 24/05/2024.
//

import SwiftUI
import ComposableArchitecture

struct BLEListView: View {
    let store: StoreOf<BLEListReducer>
    
    var body: some View  {
        NavigationView {
            List {
                if store.isScanning {
                        Text("Scanning for BLE devices")
                            .foregroundStyle(.red)
                } else {
                    Text("Scanning done")
                        .foregroundStyle(.green)
                }
                if let devices = store.bleDevices {
                    ForEach(devices, id: \.id) { device in
                        VStack(alignment: .leading) {
                            Text("Name: \(device.name ?? "")")
                            Text("RSSI : \(device.RSSI)")
                        }
                        
                    }
                }
            }
            .navigationTitle(Text("BLE Devices"))
            .onAppear {
                if !((store.bleDevices?.count ?? 0) > 0) {
                    store.send(.scanForBLEDevices)
                }
                Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { (timer) in
                    store.send(.scanForBLEDevices)
                }
            }
        }
    }
}

#Preview {
    BLEListView(store: Store(initialState: BLEListReducer.State(), reducer: {
        BLEListReducer()
    }))
}
