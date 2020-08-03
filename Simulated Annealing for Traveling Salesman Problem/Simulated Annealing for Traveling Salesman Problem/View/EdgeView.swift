//
//  EdgeView.swift
//  TSPSA
//
//  Created by Mert Arıcan on 31.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

struct EdgeView: View {
    private let edge: Edge
    private let source: CGPoint
    private let destination: CGPoint
    
    init(edge: Edge) {
        self.edge = edge
        self.source = edge.source.position.point
        self.destination = edge.destination.position.point
    }
    
    var body: some View {
        var line = Path()
        line.move(to: source)
        line.addLine(to: destination)
        return line.stroke(Color.black, lineWidth: 3.0)
    }
}

extension Position {
    var point: CGPoint {
        return CGPoint(x: self.x, y: self.y)
    }
}
