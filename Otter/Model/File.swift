//
//  File.swift
//  Otter
//
//  Created by Anthony Dejbox on 26/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import Foundation

protocol FileDelegate: class {
    func newContent(content: String)
    
}

class File {
    weak var delegate: FileDelegate?
    var url: URL
    var source: DispatchSourceProtocol?
    
    init(url: URL) {
        self.url = url
        
        subscribeToEvents()
    }
    
    func subscribeToEvents() {
        let fileDescriptor = open(url.path, O_RDONLY)
        source = DispatchSource.makeReadSource(fileDescriptor: fileDescriptor, queue: .main)
        source?.setEventHandler {
            self.read()
        }
        source?.resume()
    }
    
    func read() {
        do {
            let content = try String(contentsOf: url)
            delegate?.newContent(content: content)
        } catch {
            print(error)
        }
    }
    
    func clear() {
        do {
            try "".write(to: url, atomically: false, encoding: .utf8)
        } catch {
            print(error)
        }
        read()
    }
    
}
