//
//  Position.swift
//  TSPSA
//
//  Created by Mert Arıcan on 1.08.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

struct Position {
    static func getRandomPositionAccordingTo(maxX: Double, maxY: Double) -> Position {
        return Position(x: Double.random(in: 0...maxX), y: Double.random(in: 0...maxY))
    }
    
    static func distanceBetween(lhs: Position, rhs: Position) -> Double {
        return sqrt(pow(lhs.x - rhs.x, 2) + pow(lhs.y - rhs.y, 2))
    }
    
    let x: Double
    let y: Double
}
