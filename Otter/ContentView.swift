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
                Text("No logs!")
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            HStack() {
                Button(store.fileName ?? "Choose log file") {
                    let dialog = NSOpenPanel()
                    dialog.allowedFileTypes = ["log"]
                    if dialog.runModal() == .OK {
                        guard let url = dialog.url else { return }
                        self.store.chooseFile(url: url)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                Button("🗑") {
                    self.store.clearLogs()
                }.padding()
            }.frame(maxWidth: .infinity)
        }.frame(minWidth: 800, minHeight: 500)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
