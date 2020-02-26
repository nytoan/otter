//
//  Store.swift
//  Otter
//
//  Created by Anthony Dejbox on 22/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import Foundation
import Combine

class Store: ObservableObject {
    @Published var logs: [Log]
    @Published var file: File?
    
    @Published var searchString: String = ""
    
    var logList: [Log] {
        return LogParser().search(query: searchString, in: logs)
    }
    
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
