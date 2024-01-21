//
//  GestureButtonDefaults.swift
//  TestButtonAction
//
//  Created by Thanh Sau on 03/10/2023.
//

import Foundation

public struct GestureButtonDefaults {

    /// The max time between two taps for them to count as a double tap, by default `0.2`.
    public static var doubleTapTimeout = 0.2

    /// The time it takes for a press to count as a long press, by default `0.5`.
    public static var longPressDelay = 0.5

    /// The time it takes for a press to count as a repeat trigger, by default `0.5`.
    public static var repeatDelay = 0.5
}
