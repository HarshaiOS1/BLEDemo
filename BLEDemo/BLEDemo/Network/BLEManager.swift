//
//  BLEManager.swift
//  BLEDemo
//
//  Created by Krishnappa, Harsha on 24/05/2024.
//

import Foundation
import CoreBluetooth

//protocol BLEManagerDelegate: AnyObject {
//    func bleManager(fetchdDevices: [BLEDevice])
//}

class BLEManager: NSObject, ObservableObject {
    var centralManager: CBCentralManager!
    var scannedBLEDevices: [BLEDevice] = []
//    weak var delegate: BLEManagerDelegate?
    
    override init() {
        super.init()
    }
    
    func startCentralManger() -> [BLEDevice]? {
        centralManager = CBCentralManager(delegate: self, queue: nil)
        self.centralManagerDidUpdateState(self.centralManager)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.centralManager.stopScan()
        }
        if !centralManager.isScanning {
            return scannedBLEDevices
        }
        return nil
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
        let identifier = peripheral.identifier.uuidString.prefix(5)
        let name = peripheral.name ?? String(identifier)
        if !scannedBLEDevices.contains(where: { $0.name == name }) {
            let device = BLEDevice(id: peripheral.identifier, name: name, RSSI: RSSI.intValue)
            if let index = scannedBLEDevices.firstIndex(where: { $0.name ?? "" > name }) {
                scannedBLEDevices.insert(device, at: index)
            } else {
                scannedBLEDevices.append(device)
            }
        }
    }

}
