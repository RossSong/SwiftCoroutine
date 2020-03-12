//
//  Coroutine+Delay.swift
//  SwiftCoroutine
//
//  Created by Alex Belozierov on 04.01.2020.
//  Copyright © 2020 Alex Belozierov. All rights reserved.
//

import Dispatch

extension Coroutine {
    
    // MARK: - delay
    
    @inlinable public static func delay(_ sec: Double) throws {
        try delay(.now() + .milliseconds(Int(sec * 1000)))
    }
    
    @inlinable public static func delay(_ time: DispatchTime) throws {
        let coroutine = try current()
        let timer = DispatchSource.createTimer(timeout: time) {
            do { try coroutine.resume() } catch { print(error) }
        }
        try coroutine.suspend(with: timer.activate)
    }
    
}