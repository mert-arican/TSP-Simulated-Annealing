//
//  Array+Reverse.swift
//  TSPSA
//
//  Created by Mert Arıcan on 1.08.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

extension Array {
    func reverseElementsBetweenIndices(_ lowIndex: Int, _ upperIndex: Int) -> [Element] {
        let p1 = self[0..<lowIndex]
        let reversedPart = self[lowIndex...upperIndex].reversed()
        let p2 = self[(upperIndex+1)...]
        return Array(p1+reversedPart+p2)
    }
}
