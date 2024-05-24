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
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                List {
                    if viewStore.isScanning {
                        ProgressView()
                    }
                    if let devices = viewStore.bleDevices {
                        ForEach(devices, id: \.id) { device in
                            Text(device.name ?? "")
                        }
                    }
                }
                .navigationTitle(Text("BLE Devices"))
                .onAppear {
                    viewStore.send(.scanForBLEDevices)
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
