//
//  NSTableView.swift
//  Otter
//
//  Created by Anthony Dejbox on 27/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import AppKit

extension NSTableView {
    open override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        backgroundColor = Constants.Color.backgroundList
    }
}
