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
            VStack {
                HStack(alignment: .top) {
                    Text(log.title)
                        .lineLimit(1)
                        .font(.custom("Arial", size: 12))
                    Spacer()
                    Text("\(log.lineCount) lines")
                        .font(.custom("Arial", size: 11))
                }
                .frame(minHeight: 30)
                if isOpen {
                    Spacer()
                    ScrollView {
                        Text(log.text)
                            .font(.custom("Arial", size: 12))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .frame(maxHeight: 300)
                    .padding()
                    .background(Color(red: 0.1, green: 0.1, blue: 0.15))
                }
            }
            Divider()
            VStack {
                Image("chevron")
                    .rotationEffect(.degrees(
                        isOpen ? 180 : 0
                    )).frame(minHeight: 30)
                if isOpen {
                    Spacer()
                }
            }
        }
        .padding(8)
        .background(Color(red: 0.1, green: 0.25, blue: 0.35))
        .padding(-2)
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
                text: "[ 200 ] - https://www.efgoisder.com/token"
            )
        )
    }
}
