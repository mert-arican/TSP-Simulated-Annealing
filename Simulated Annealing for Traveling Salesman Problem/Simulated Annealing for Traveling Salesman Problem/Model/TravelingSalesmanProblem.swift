//
//  SimulatedAnnealing.swift
//  TSPSA
//
//  Created by Mert Arıcan on 1.08.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

class TravelingSalesmanProblem {
    private(set) var randomNodes: [Node] = []
    private(set) var allEdges = [Edge]() { didSet { self.updateFunction?() } }
    private var updateFunction: (()->())!
    
    func setRandomNodes(_ count: Int, maxX: Double, maxY: Double) {
        var nodes = [Node]()
        for _ in 1...count {
            let node = Node(position: Position.getRandomPositionAccordingTo(maxX: maxX, maxY: maxY))
            nodes.append(node)
        }
        nodes.append(nodes.first!)
        randomNodes = nodes
        setEdgesAccordingToNodes(mutateAllEdges: true)
    }
    
    @discardableResult
    private func setEdgesAccordingToNodes(mutateAllEdges: Bool, nodes: [Node]?=nil) -> (nodes: [Node], edges: [Edge]) {
        let randomNodes = nodes ?? self.randomNodes
        var edges = [Edge]()
        for (index, node) in randomNodes.enumerated() {
            if index == randomNodes.indices.last! { edges.append(Edge(source: randomNodes.last!, destination: randomNodes.first!)) }
            else { edges.append(Edge(source: node, destination: randomNodes[index+1])) }
        }
        if mutateAllEdges { allEdges = edges }
        return (randomNodes, edges)
    }
        
    // MARK: - Simulated Annealing Section
    
    private var pathSize: Int = 0
    private var currentSolution: [Edge] = []
    private var bestSolution: [Edge] = []
    private var currentWeight: Double = 1000000
    private var minWeight: Double = 1000000
    private var stoppingTemperature: Double = 0.0
    private var temperature: Double = 0.0
    private var alpha: Double = 0.0
    private var MAX_ITER: Int = 1000000
    var bestDistance: Double?
    var initialDistance: Double = 0
    
    init(MAX_ITER: Int=1000000, updateFunc: @escaping ()->()) {
        self.MAX_ITER = MAX_ITER
        self.updateFunction = updateFunc
    }
    
    private func prepareForAnneal(temperature: Double, alpha: Double, stoppingTemperature: Double) {
        self.temperature = temperature
        self.alpha = alpha
        self.stoppingTemperature = stoppingTemperature
        self.bestSolution = []
        self.minWeight = 1000000
        self.currentSolution = self.allEdges
        self.currentWeight = self.weight(of: self.currentSolution)
        self.pathSize = self.randomNodes.count
        self.initialDistance = self.currentWeight
        self.bestDistance = nil
    }
    
    private func weight(of path: [Edge]) -> Double {
        return path.map { $0.length }.reduce(0, +)
    }
    
    private func acceptanceProbabilityOfPathWith(weight: Double) -> Double {
        return pow(M_E, -(fabs(weight - self.currentWeight) / self.temperature))
    }
    
    private func assignCandidateAsASolution(candidateNodes: [Node], candidatePath: [Edge], candidateWeight: Double) {
        self.currentWeight = candidateWeight
        self.currentSolution = candidatePath
        self.randomNodes = candidateNodes
        self.setEdgesAccordingToNodes(mutateAllEdges: true)
    }
    
    private func accept(candidatePath: [Edge], candidateNodes: [Node]) {
        let candidateWeight = self.weight(of: candidatePath)
        if candidateWeight < self.currentWeight {
            assignCandidateAsASolution(candidateNodes: candidateNodes, candidatePath: candidatePath, candidateWeight: candidateWeight)
            if candidateWeight < self.minWeight {
                self.minWeight = candidateWeight
                self.bestSolution = candidatePath
            }
        } else if Double.random(in: 0...1) < self.acceptanceProbabilityOfPathWith(weight: candidateWeight) {
            assignCandidateAsASolution(candidateNodes: candidateNodes, candidatePath: candidatePath, candidateWeight: candidateWeight)
        }
    }
    
    func anneal(temperature: Double, alpha: Double, stoppingTemperature: Double) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.prepareForAnneal(temperature: temperature, alpha: alpha, stoppingTemperature: stoppingTemperature)
            var iterationCount = 0
            print(self.currentWeight)
            while self.temperature >= self.stoppingTemperature && iterationCount < self.MAX_ITER {
                let t1 = Int.random(in: 2..<self.pathSize)
                let t2 = Int.random(in: 0..<self.pathSize-t1)
                
                let candidateRandomNodes = self.randomNodes.reverseElementsBetweenIndices(t2, t1+t2)
                let candidateSolution = self.setEdgesAccordingToNodes(mutateAllEdges: false, nodes: candidateRandomNodes)
                
                self.accept(candidatePath: candidateSolution.edges, candidateNodes: candidateSolution.nodes)
                self.temperature *= self.alpha
                iterationCount += 1
            }
            self.bestDistance = self.minWeight
            print(self.minWeight)
            print(self.currentWeight)
        }
    }
    
    // Clearing all of the edges is going to cause new set of random points.
    func newPath() { self.allEdges = []; self.bestDistance = nil ; self.initialDistance = 0 }
}
