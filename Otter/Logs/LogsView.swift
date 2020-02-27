//
//  LogsView.swift
//  Otter
//
//  Created by Anthony Dejbox on 22/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import SwiftUI

struct LogsView: View {
    var logs: [Log]
    
    var body: some View {
        List(logs.enumerated().map{$0}, id: \.1.id) { (idx, log) in
            LogView(log: log).background(idx % 2 == 0 ? Color("background") : Color.clear)
        }
    }
    
}

struct LogsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsView(logs: [
            Log(
                id: 0, 
                text: "[ 200 ] - https://www.efgoisder.com/tokens"
            ),
            Log(
                id: 1, 
                text: "[ 200 ] - https://www.efgoisder.com/tokens"
            ),
            Log(
                id: 2, 
                text: "[ 200 ] - https://www.efgoisder.com/tokens"
            )
        ])
    }
    
}
