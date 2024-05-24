//
//  BLEManager.swift
//  BLEDemo
//
//  Created by Krishnappa, Harsha on 24/05/2024.
//

import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject {
    var centralManager: CBCentralManager!
    var scannedBLEDevices: [String] = []
    
    override init() {
        super.init()
    }
    
    func startCentralManger() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
}

extension BLEManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch (central.state) {
        case .unsupported, .unauthorized, .unknown, .resetting, .poweredOff:
            print("Error with ble device")
            break
        case .poweredOn:
            print("scanning for devices")
            break
        @unknown default:
            print("unknown error")
            break
        }
    }
}
