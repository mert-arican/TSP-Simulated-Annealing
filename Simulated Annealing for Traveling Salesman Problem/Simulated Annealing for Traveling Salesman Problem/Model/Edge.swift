//
//  Edge.swift
//  TSPSA
//
//  Created by Mert Arıcan on 31.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

struct Edge: Identifiable {
    var id: UUID { return UUID() }
    let source: Node
    let destination: Node
    var length: Double {
        return Position.distanceBetween(lhs: source.position, rhs: destination.position)
    }
}
