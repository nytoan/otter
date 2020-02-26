//
//  Color+Log.swift
//  Otter
//
//  Created by Anthony Dejbox on 26/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import SwiftUI

extension Color {
    static func getColorFromLog(log: Log) -> Color {
        
        for param in log.params {
            if case let .color(hexString) = param {
                let mask = 0x000000FF
                let scanner = Scanner(string: hexString)
                var color: UInt64 = 0
                scanner.scanHexInt64(&color)
                let r: Double = Double(Int(color >> 16) & mask) / 255.0
                let g: Double = Double(Int(color >> 8) & mask) / 255.0
                let b: Double = Double(Int(color) & mask) / 255.0
                return Color(red: r, green: g, blue: b)                
            }
        }
        
        return Color(NSColor(named: "defaultBar")!)
    }
    
}
