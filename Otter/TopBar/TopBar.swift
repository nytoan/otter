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
        TextField("Search", text: $searchString)
            .textFieldStyle(PlainTextFieldStyle())
            .padding(8)
            .background(Color(NSColor(named: "textFieldBackground")!))
            .cornerRadius(4)
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16))
            .disableAutocorrection(true)
    }
    
}

struct TopBar_Previews: PreviewProvider {
    @State static var test = ""
    
    static var previews: some View {
        TopBar(searchString: $test)
        .frame(width: 200, height: 80)
    }
    
}
