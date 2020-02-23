//
//  LogView.swift
//  Otter
//
//  Created by Anthony Dejbox on 23/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import SwiftUI

struct LogView: View {
    
    var log: Log
    
    @State private var isOpen: Bool = false
    
    var body: some View {
        HStack {
            if isOpen {
                Text(log.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text(log.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Divider()
            Image("chevron")
                .rotationEffect(.degrees(
                    isOpen ? 180 : 0
                ))
                .frame(maxHeight: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(red: 0.1, green: 0.3, blue: 0.4))
        .onTapGesture {
            self.isOpen = !self.isOpen
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView(log:
            Log(
                id: 0, 
                text: "[ 200 ] - https://www.efgoisder.com/tokens"
            )
        )
    }
}
