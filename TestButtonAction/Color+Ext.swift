//
//  Color+Ext.swift
//  TestButtonAction
//
//  Created by Thanh Sau on 03/10/2023.
//

import Foundation
import SwiftUI

extension Color {
    static func random(
        in range: ClosedRange<Double> = 0...1,
        randomOpacity: Bool = false
    ) -> Color {
        Color(
            red: .random(in: range),
            green: .random(in: range),
            blue: .random(in: range),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}
