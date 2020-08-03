//
//  NodeView.swift
//  TSPSA
//
//  Created by Mert Arıcan on 31.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

struct NodeView: View {
    let node: Node
    
    var body: some View {
        Circle()
            .fill(Color.black)
            .frame(width: 10.0)
    }
}
