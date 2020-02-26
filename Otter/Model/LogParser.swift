//
//  LogParser.swift
//  Otter
//
//  Created by Anthony Dejbox on 26/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import Foundation

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
