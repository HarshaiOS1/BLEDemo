//
//  BLEListReducer.swift
//  BLEDemo
//
//  Created by Krishnappa, Harsha on 24/05/2024.
//

import Foundation
import ComposableArchitecture

class BLEListReducer: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var bleDevices: [BLEDevice]?
        var isScanning: Bool = true
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
                let devices = await BLEManager.shared.startCentralManger()
                if let dev = devices {
                    await send(.devicesFetched(dev))
                }
            }
        case .devicesFetched(let bleDevices):
            state.isScanning = false
            print("device count :: \(String(describing: bleDevices?.count))" )
            state.bleDevices = bleDevices
            return .none
        }
    }
}
