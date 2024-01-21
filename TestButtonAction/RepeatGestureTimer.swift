//
//  RepeatGestureTimer.swift
//  TestButtonAction
//
//  Created by Thanh Sau on 03/10/2023.
//

import Foundation

public class RepeatGestureTimer {

    public init() {}
    
    deinit { stop() }


    private var timer: Timer?
    
    private var startDate: Date?

    /// The timer tick interval.
    public var timeInterval: TimeInterval = 0.1
}

public extension RepeatGestureTimer {

    /// This is a shared timer instance.
    static let shared = RepeatGestureTimer()
}

public extension RepeatGestureTimer {

    /// The time for how long the timer has been active.
    var duration: TimeInterval? {
        guard let date = startDate else { return nil }
        return Date().timeIntervalSince(date)
    }

    /// Whether or not the timer is active.
    var isActive: Bool { timer != nil }

    /// Start the timer.
    func start(action: @escaping () -> Void) {
        if isActive { return }
        stop()
        startDate = Date()
        let timer = Timer.scheduledTimer(
            withTimeInterval: timeInterval,
            repeats: true) { _ in action() }
        self.timer = timer
        RunLoop.current.add(timer, forMode: .common)
    }

    /// Stop the timer.
    func stop() {
        timer?.invalidate()
        timer = nil
        startDate = nil
    }
}

extension RepeatGestureTimer {
    
    func modifyStartDate(to date: Date) {
        startDate = date
    }
}
