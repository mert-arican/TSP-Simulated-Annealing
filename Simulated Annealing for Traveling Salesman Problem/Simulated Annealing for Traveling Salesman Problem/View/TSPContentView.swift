//
//  TSPContentView.swift
//  TSPSA
//
//  Created by Mert Arıcan on 31.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

struct TSPContentView: View {
    @ObservedObject var viewModel = TSPViewModel()
    
    private func getAllEdges(count: Int, maxX: CGFloat, maxY: CGFloat) -> [Edge] {
        if (self.viewModel.allEdges.count-1) != self.count { self.viewModel.setRandomNodes(count, maxX: Double(maxX), maxY: Double(maxY)) }
        return self.viewModel.allEdges
    }
    
    @State private var text: String = ""
    @State private var count = 70
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Initial distance: \n\(self.viewModel.initialWeight)")
                        .commonModifier()
                        .multilineTextAlignment(.center)
                    Text(self.viewModel.minWeight != nil ? "Minimum distance: \n\(self.viewModel.minWeight!)" : "Best path haven't found yet.")
                        .commonModifier()
                        .multilineTextAlignment(.center)
                }.padding(5)
                GeometryReader { geometry in
                    ForEach(self.getAllEdges(count: self.count, maxX: geometry.size.width-20.0, maxY: geometry.size.height-20.0)) { edge in
                        Group {
                            NodeView(node: edge.source)
                                .position(edge.source.position.point)
                            NodeView(node: edge.destination)
                                .position(edge.destination.position.point)
                            EdgeView(edge: edge)
                        }
                    }
                    .padding(10)
                }
                .background(Color.gray)
                .onTapGesture {
                    self.count = Int(self.text) ?? self.count
                    self.hideKeyboard()
                }
                ScrollView(.horizontal) {
                    HStack {
                        Button(action: {
                            self.viewModel.anneal()
                        }) { Text("Anneal") }
                            .commonModifier()
                        Button(action: {
                            self.viewModel.newPath()
                        }) { Text("New Random Path") }
                            .commonModifier()
                        TextField("Number of nodes: \(self.count)", text: self.$text)
                            .commonModifier()
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                    }
                    .padding(5)
                }
            }
            Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.75)
                .edgesIgnoringSafeArea(.all)
                .zIndex(-1)
        }
        
    }
    
}

extension CGPoint {
    func offSet(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
