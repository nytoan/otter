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
                .frame(width: 4)
            VStack {
                HStack(alignment: .top) {
                    Text(log.title)
                        .lineLimit(1)
                        .font(Font.system(size: 12, weight: .regular, design: .monospaced))
                    Spacer()
                    Text("\(log.lineCount) lines")
                        .font(.custom("HelveticaNeue-MediumItalic", size: 11))
                }
                .frame(minHeight: 30)
                if isOpen {
                    Spacer()
                    ScrollView {
                        TextView(text: log.text)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(maxHeight: 300)
                    .padding()
                    .background(Color(Constants.Color.backgroundLog))
                    .cornerRadius(2)
                    Spacer()
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
        .padding([.top, .bottom], 4)
        .background(Color.init(white: 0).opacity(0.01))
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
            ).frame(width: 500, height: 40)
            LogView(log:
                Log(
                    id: 0, 
                    text: "[ 200 ] - https://www.efgoisder.com/token\nbla bla bla"
                ),
                isOpen: true
            ).frame(width: 500, height: 300)
        }
    }
}
