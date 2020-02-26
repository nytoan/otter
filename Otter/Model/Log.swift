//
//  Log.swift
//  Otter
//
//  Created by Anthony Dejbox on 26/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import Foundation

struct Log: Identifiable {
    enum Parameter: Equatable {
        case color(string: String)
    }
    
    var id: Int
    var text: String
    var params: [Parameter] = []
    
    var title: String {
        return text.components(separatedBy: "\n").first ?? ""
    }
    var lineCount: Int {
        return text.components(separatedBy: "\n").count
    }
    
}
