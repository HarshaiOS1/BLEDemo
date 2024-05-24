//
//  BLEListReducer.swift
//  BLEDemo
//
//  Created by Krishnappa, Harsha on 24/05/2024.
//

import Foundation
import ComposableArchitecture

class BLEListReducer: Reducer {
    
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
            return .none
        case .devicesFetched:
            return .none
        }
    }
}
