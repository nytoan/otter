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
    var title: String
    var content: String
    var font: NSFont = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
    var textColor: NSColor = .init(white: 0.9, alpha: 1)
    
    func updateNSView(_ nsView: CustomTextView, context: NSViewRepresentableContext<TextView>) {
        nsView.font = font
        nsView.textColor = textColor
        let attrString = NSMutableAttributedString()
        attrString.append(
            NSAttributedString(string: title + "\n", attributes: [
                NSAttributedString.Key.foregroundColor : NSColor(white: 0.7, alpha: 1),
                NSAttributedString.Key.font : NSFont.monospacedSystemFont(ofSize: 11, weight: .medium)
            ])
        )
        attrString.append(
            NSAttributedString(string: content, attributes: [
                NSAttributedString.Key.foregroundColor : textColor,
                NSAttributedString.Key.font : font
            ])
        )
        nsView.textStorage?.setAttributedString(attrString)
    }
    
    func makeNSView(context: NSViewRepresentableContext<TextView>) -> CustomTextView {
        let tv = CustomTextView(frame: .zero)
        tv.isEditable = false
        tv.font = font
        tv.textColor = textColor
        tv.setContentHuggingPriority(.required, for: .horizontal)
        tv.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        tv.backgroundColor = .clear
        return tv
    }
}
