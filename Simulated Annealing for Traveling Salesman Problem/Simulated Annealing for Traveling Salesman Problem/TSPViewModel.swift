//
//  TSPViewModel.swift
//  TSPSA
//
//  Created by Mert Arıcan on 1.08.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

class TSPViewModel: ObservableObject {
    @Published var model: TravelingSalesmanProblem!
    var allEdges: [Edge] { return model.allEdges }
    var allNodes: [Node] { return model.randomNodes }
    
    var minWeight: Int? {
        return (model.bestDistance != nil) ? Int(model.bestDistance!) : nil
    }
    
    var initialWeight: Int {
        return Int(model.initialDistance)
    }
    
    func update() {
        DispatchQueue.main.async { [weak self] in
            self?.objectWillChange.send()
        }
    }
    
    init() { self.model = TravelingSalesmanProblem(updateFunc: self.update) }
    
    func setRandomNodes(_ count: Int, maxX: Double, maxY: Double) {
        model.setRandomNodes(count, maxX: maxX, maxY: maxY)
    }
    
    // MARK: - Intents
    
    func anneal() { self.model.anneal(temperature: 1000, alpha: 0.9995, stoppingTemperature: 0.00000001) }
    func newPath() { self.model.newPath() }
}
