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
        
        enclosingScrollView?.scrollerInsets = NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        
        intercellSpacing = NSSize(width: 0, height: -8)
    }
}
