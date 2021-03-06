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
    
    @State var isOpen: Bool = false
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.getColorFromLog(log: log))
                .frame(width: 6)
                .cornerRadius(3)
            VStack {
                HStack(alignment: .top) {
                    Text(log.title)
                        .lineLimit(1)
                        .font(Font.system(size: 12, weight: .regular, design: .monospaced))
                    Spacer()
                    Text("\(log.lineCount) lines")
                        .font(.custom("HelveticaNeue-MediumItalic", size: 11))
                }
                .frame(minHeight: 24)
                if isOpen {
                    ScrollView {
                        TextView(title: log.title, content: log.content)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(maxHeight: 400)
                    .padding()
                    .background(Color(Constants.Color.backgroundLog))
                    .cornerRadius(4)
                }
            }
            Divider()
            VStack {
                Image("chevron")
                    .rotationEffect(.degrees(
                        isOpen ? 180 : 0
                    )).frame(minHeight: 24)
                if isOpen {
                    Spacer()
                }
            }
        }
        .padding(8)
        .padding([.trailing], 10)
        .contentShape(Rectangle())
        .onTapGesture {
            self.isOpen = !self.isOpen
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LogView(log:
                Log(
                    id: 0, 
                    text: "[ 200 ] - https://www.efgoisder.com/token\nbla bla bla"
                )
            ).previewLayout(.fixed(width: 500, height: 100))
            LogView(log:
                Log(
                    id: 0, 
                    text: "[ 200 ] - https://www.efgoisder.com/token\nbla bla bla"
                ),
                isOpen: true
            ).previewLayout(.fixed(width: 500, height: 500))
        }
    }
}
