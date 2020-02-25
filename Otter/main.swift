//
//  main.swift
//  Otter
//
//  Created by Anthony Dejbox on 25/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import AppKit

let app = NSApplication.shared

if NSClassFromString("XCTest") != nil {
    let delegate: NSObject.Type? = NSClassFromString("TestAppDelegate") as? NSObject.Type
    app.delegate = delegate?.init() as? NSApplicationDelegate
    app.run()
} else {
    _ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
}
