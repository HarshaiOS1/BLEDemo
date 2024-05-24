//
//  BLEDevice.swift
//  BLEDemo
//
//  Created by Krishnappa, Harsha on 24/05/2024.
//

import Foundation

struct BLEDevice: Identifiable, Equatable {
    let id: UUID?
    let name: String?
    let RSSI: Int
}
