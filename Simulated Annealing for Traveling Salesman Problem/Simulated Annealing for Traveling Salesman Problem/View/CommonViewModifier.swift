//
//  commonViewModifier.swift
//  TSPSA
//
//  Created by Mert Arıcan on 3.08.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

struct CommonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .multilineTextAlignment(.center)
            .border(Color.black, width: 3.0)
            .cornerRadius(8.0)
    }
}

extension View {
    func commonModifier() -> some View {
        self.modifier(CommonViewModifier())
    }
}
