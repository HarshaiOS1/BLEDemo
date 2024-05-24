//
//  BLEListReducer.swift
//  BLEDemo
//
//  Created by Krishnappa, Harsha on 24/05/2024.
//

import Foundation
import ComposableArchitecture

class BLEListReducer: Reducer {
    let bleManager = BLEManager()
    struct State {
        var bleDevices: [BLEDevice]?
        var isScanning: Bool = false
    }
    
    enum Action {
        case scanForBLEDevices
        case devicesFetched([BLEDevice]?)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .scanForBLEDevices:
            state.isScanning = true
            return .run { send in
                let devices = self.bleManager.startCentralManger()
                if let dev = devices {
                    await send(.devicesFetched(dev))
                }
            }
        case .devicesFetched(let bleDevices):
            state.bleDevices = bleDevices
            state.isScanning = false
            return .none
        }
    }
}
