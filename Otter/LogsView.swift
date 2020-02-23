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
    
    @State private var openedIndexes: [Int] = []
    
    var body: some View {
        List(logs) { log in
            HStack {
                if self.openedIndexes.contains(log.id) {
                    Text(log.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text(log.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Divider()
                Button("toggle") {
                    if self.openedIndexes.contains(log.id) {
                        self.openedIndexes = self.openedIndexes.filter { $0 != log.id }
                    } else {
                        self.openedIndexes.append(log.id)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(red: 0.1, green: 0.3, blue: 0.4))
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
