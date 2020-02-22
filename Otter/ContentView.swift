//
//  ContentView.swift
//  Otter
//
//  Created by Anthony Dejbox on 22/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store = Store()
    
    var body: some View {
        VStack {
            if store.hasLogs {
                LogsView(logs: store.logs)
            } else {
                Text("Hello, World!")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            HStack() {
                Button(store.fileName ?? "Log file") {
                    let dialog = NSOpenPanel()
                    dialog.allowedFileTypes = ["log"]
                    if dialog.runModal() == .OK {
                        guard let path = dialog.url?.path else { return }
                        self.store.chooseFile(path: path)
                    }
                }
                Button("Delete") {
                    self.store.clearLogs()
                }
            }.frame(maxWidth: .infinity)
        }.frame(minWidth: 800, minHeight: 500)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
