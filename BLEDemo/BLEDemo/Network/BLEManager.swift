//
//  BLEManager.swift
//  BLEDemo
//
//  Created by Krishnappa, Harsha on 24/05/2024.
//

import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject {
    static let shared = BLEManager()
    
    private var centralManager: CBCentralManager!
    var peripheral: CBPeripheral?
    @Published var scannedBLEDevices: [BLEDevice] = []
    
    override init() {
        super.init()
    }
    
    func startCentralManger() async -> [BLEDevice]? {
        centralManager = CBCentralManager(delegate: self, queue: nil)
        self.centralManagerDidUpdateState(self.centralManager)
        do {
            try await Task.sleep(nanoseconds: 2 * 1_000_000_100) // 1 second delay
        } catch {
            print("error")
        }
        self.centralManager = nil
        return scannedBLEDevices
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
        print(peripheral)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            central.stopScan()
        }
    }

}
