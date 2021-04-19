//
//  Motion.swift
//  virtual-weapon
//
//  Created by Ming Sun on 4/8/21.
//

import Foundation
import CoreMotion



class Motion {

    private let manager = CMMotionManager()
    private var isDeviceMotionAvailable: Bool { manager.isDeviceMotionAvailable }
    var deviceMotion: CMDeviceMotion? { manager.deviceMotion }
    var gyroData: CMGyroData? { manager.gyroData }
    var magnetometerData: CMMagnetometerData? { manager.magnetometerData }
    var accelerometerData: CMAccelerometerData? { manager.accelerometerData }

    init() {
        manager.deviceMotionUpdateInterval = 0.3
        manager.gyroUpdateInterval = 0.3
        manager.magnetometerUpdateInterval = 0.3
        manager.accelerometerUpdateInterval = 0.3
    }

    deinit {
        stopUpdate()
    }

    func startUpdate() {
        manager.startDeviceMotionUpdates()
        manager.startGyroUpdates()
        manager.startMagnetometerUpdates()
        manager.startAccelerometerUpdates()
    }

    func stopUpdate() {
        manager.stopDeviceMotionUpdates()
        manager.stopGyroUpdates()
        manager.stopMagnetometerUpdates()
        manager.stopAccelerometerUpdates()
    }

}
