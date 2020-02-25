//
//  TextView.swift
//  Otter
//
//  Created by Anthony Dejbox on 25/02/2020.
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
