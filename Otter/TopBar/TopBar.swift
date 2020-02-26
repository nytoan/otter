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
                .padding([.top], 16)
            TextField("Search", text: $searchString)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
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
