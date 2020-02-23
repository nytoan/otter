//
//  Store.swift
//  Otter
//
//  Created by Anthony Dejbox on 22/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import Foundation
import Combine
    
class LogParser {
    func generateLogs(string: String) -> [Log] {
        
        let otterTag = "[otter]"
        
        var logs: [Log] = []
        var currentLogContent = ""
        var i = 1
        for line in string.components(separatedBy: "\n") {
            if line.contains(otterTag) && !currentLogContent.isEmpty {
                logs.append(
                    Log(
                        id: i, 
                        text: currentLogContent
                    )
                )
                i += 1
                currentLogContent = ""
            }
            currentLogContent += line.replacingOccurrences(of: otterTag, with: "") + "\n"
        }
        return logs.reversed()
    }
    
}

struct Log: Identifiable {
    var id: Int
    var text: String
    var title: String {
        return text.components(separatedBy: "\n").first ?? ""
    }
    
}

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
        source = DispatchSource.makeFileSystemObjectSource(fileDescriptor: fileDescriptor, eventMask: .all, queue: DispatchQueue.main)
        source?.setEventHandler {
            self.read()
            self.subscribeToEvents()
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

class Store: ObservableObject {
    @Published var logs: [Log]
    @Published var file: File?
    
    private var parser: LogParser
    
    var hasLogs: Bool {
        return !logs.isEmpty
    }
    
    var fileLoaded: Bool {
        return file != nil
    }
    
    var fileName: String? {
        return file?.url.path.components(separatedBy: "/").last
    }
    
    init() {
        logs = []
        parser = LogParser()
    }
    
    func clearLogs() {
        file?.clear()
    }
    
    func chooseFile(url: URL) {
        file = File(url: url)
        file?.delegate = self
        file?.read()
    }
    
}

extension Store: FileDelegate {
    func newContent(content: String) {
        logs = parser.generateLogs(string: content)
    }
    
}
