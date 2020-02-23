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
                VStack {
                    Text(log.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                    TextField("", text: .constant(log.text))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(red: 0.1, green: 0.1, blue: 0.15))
                        .cornerRadius(4)
                }
            } else {
                Text(log.title)
                    .bold()
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
        .cornerRadius(4)
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
