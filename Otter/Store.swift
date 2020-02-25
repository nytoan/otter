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
    let otterOpenTag = "[otter"
    let otterCloseTag = "[/otter]"
    
    func generateLogs(string: String) -> [Log] {
        
        var logs: [Log?] = []
        var currentLog: Log?
        
        for line in string.components(separatedBy: "\n") {
            if line.contains(otterOpenTag) {
                if currentLog != nil {
                    currentLog?.text += line + "\n"
                } else {
                    currentLog = Log(
                        id: logs.count, 
                        text: "",
                        params: getOpenTagParams(string: line)
                    )
                }
            } else if line.contains(otterCloseTag) {
                if currentLog != nil {
                    logs.append(currentLog)
                    currentLog = nil
                }
            } else {
                if currentLog != nil {
                    currentLog?.text += line + "\n"
                }
            }
        }
        return logs.compactMap{$0}.reversed()
    }
    
    private func getOpenTagParams(string: String) -> [Log.Parameter] {
        return string
            .trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: "[otter]", with: "")
            .replacingOccurrences(of: "[otter ", with: "")
            .replacingOccurrences(of: "]", with: "")
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .map { param in
                let arr = param.components(separatedBy: "=")
                let key = arr[0]
                let value:String = String(arr[1].dropFirst().dropLast())
                if key == "color" {
                    return Log.Parameter.color(string: value)
                }
                return nil
        }.compactMap{$0}
    }
    
}

struct Log: Identifiable {
    enum Parameter: Equatable {
        case color(string: String)
    }
    
    var id: Int
    var text: String
    var params: [Parameter] = []
    
    var title: String {
        return text.components(separatedBy: "\n").first ?? ""
    }
    var lineCount: Int {
        return text.components(separatedBy: "\n").count
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
        
        guard let url = UserDefaults.standard.url(forKey: "url") else { return }
        chooseFile(url: url)
    }
    
    func clearLogs() {
        file?.clear()
    }
    
    func chooseFile(url: URL) {
        file = File(url: url)
        
        guard file != nil else { return }
        
        UserDefaults.standard.set(url, forKey: "url")
        
        file?.delegate = self
        file?.read()
    }
    
}

extension Store: FileDelegate {
    func newContent(content: String) {
        logs = parser.generateLogs(string: content)
    }
    
}
