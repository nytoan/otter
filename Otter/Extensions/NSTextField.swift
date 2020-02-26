//
//  NSTextField.swift
//  Otter
//
//  Created by Anthony Dejbox on 27/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import AppKit

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none } 
        set {}
    }
}
