//
//  TopBar.swift
//  Otter
//
//  Created by Anthony Dejbox on 26/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import SwiftUI

struct TopBar: View {
    
    @Binding var searchString: String
    
    var body: some View {
        VStack {
            Divider()
            TextField("🤓 Hey ! Type here to search...", text: $searchString)
                .font(Font.system(size: 14, weight: .medium, design: .monospaced))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .disableAutocorrection(true)
            Divider()
        }
    }
}

struct TopBar_Previews: PreviewProvider {
    @State static var test = ""
    
    static var previews: some View {
        TopBar(searchString: $test)
        .frame(width: 300, height: 200)
    }
}
