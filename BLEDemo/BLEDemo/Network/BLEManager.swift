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
        self.centralManagerDidUpdateState(self.centralManager)
    }
}

//MARK: CBCentralManagerDelegate
extension BLEManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch (central.state) {
        case .unsupported, .unauthorized, .unknown, .resetting, .poweredOff:
            print("Error with ble device")
            break
        case .poweredOn:
            print("scanning for devices")
            self.centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
            break
        @unknown default:
            print("unknown error")
            break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let name = peripheral.name ?? String(peripheral.identifier.uuidString.prefix(5))
        scannedBLEDevices.append(name)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            central.stopScan()
            print(self.scannedBLEDevices)
        }
    }

}
