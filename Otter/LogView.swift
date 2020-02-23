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
                Text(log.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.bottom, isOpen ? 10 : 0)
                if isOpen {
                    ScrollView {
                        Text(log.text)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .frame(maxHeight: 300)
                    .padding()
                    .background(Color(red: 0.1, green: 0.1, blue: 0.15))
                    .cornerRadius(4)
                }
            }
            Divider()
            Image("chevron")
                .rotationEffect(.degrees(
                    isOpen ? 180 : 0
                ))
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .padding()
        .background(Color(red: 0.1, green: 0.3, blue: 0.4))
        .cornerRadius(4)
        .padding(EdgeInsets(top: 4, leading: 4, bottom: 0, trailing: 4))
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
