//
//  LogView.swift
//  Otter
//
//  Created by Anthony Dejbox on 23/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import SwiftUI

class CustomTextView: NSTextView {
  override var intrinsicContentSize: NSSize {
    guard let manager = textContainer?.layoutManager else {
      return .zero
    }

    manager.ensureLayout(for: textContainer!)

    return manager.usedRect(for: textContainer!).size
  }
}

struct TextView: NSViewRepresentable {
    var text: String
    
    func updateNSView(_ nsView: CustomTextView, context: NSViewRepresentableContext<TextView>) {
        nsView.string = text
    }
    
    func makeNSView(context: NSViewRepresentableContext<TextView>) -> CustomTextView {
        let tv = CustomTextView(frame: .zero)
        tv.setContentHuggingPriority(.required, for: .horizontal)
        tv.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        tv.backgroundColor = .clear
        return tv
    }
}

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
                        TextView(text: log.text)
                            .frame(maxWidth: .infinity)
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
