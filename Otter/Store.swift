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
        var i = -1
        return string.components(separatedBy: "\n").map {
            i += 1
            return Log(id: i, text: $0)
        }
    }
    
}

struct Log: Identifiable {
    var id: Int
    var text: String
    
}

protocol FileDelegate: class {
    func newContent(content: String)
    
}

class File {
    weak var delegate: FileDelegate?
    var path: String?
    
    init(path: String) {
        self.path = path
    }
    
    func read() {
        guard let path = path else { return }
        do {
            let content = try String(contentsOfFile: path)
            delegate?.newContent(content: content)
        } catch {
            print(error)
        }
    }
    
    func clear() {
        guard let path = path else { return }
        do {
            try "".write(toFile: path, atomically: true, encoding: .utf8)
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
    
    var fileName: String? {
        return file?.path?.components(separatedBy: "/").last
    }
    
    init() {
        logs = []
        parser = LogParser()
    }
    
    func clearLogs() {
        file?.clear()
    }
    
    func chooseFile(path: String) {
        file = File(path: path)
        file?.delegate = self
        file?.read()
    }
    
}

extension Store: FileDelegate {
    func newContent(content: String) {
        logs = parser.generateLogs(string: content)
    }
    
}
