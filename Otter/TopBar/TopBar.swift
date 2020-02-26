//
//  TopBar.swift
//  Otter
//
//  Created by Anthony Dejbox on 26/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import SwiftUI

struct TopBar: View {
    
    @State var searchString: String = ""
    
    var body: some View {
        TextField("Search", text: $searchString)
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16))
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
    }
}
