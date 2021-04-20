//
//  Weapons.swift
//  virtual-weapon
//
//  Created by Ming Sun on 4/8/21.
//

import Foundation



protocol GreatSwordDelegate: AnyObject {
    func charge(to phase: Int)
    func reset()
}

class GreatSword {

    weak var motion: Motion?
    weak var delegate: GreatSwordDelegate?

    enum State {
        case Charging, Releasing, None
    }
    var timer: Timer?
    var lastChargeDate: Date?
    var currentPhase: Int = 0
    var state: State {
        guard let acceleration = motion?.accelerometerData?.acceleration else { return .None }
        switch acceleration.y {
        case 0.15...:
            return .Charging
        default:
            return .Releasing
        }
    }

    init(with motion: Motion) {
        self.motion = motion
    }

    func startSimulate() {
        motion?.startUpdate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: checkMotion)
        timer?.fire()
    }

    func stopSimulate() {
        motion?.stopUpdate()
        timer?.invalidate()
        timer = nil
        currentPhase = 0
        delegate?.reset()
    }

    func checkMotion(_ timer: Timer) {
        if state == .Charging {
            if shouldTriggerCharge() {
                delegate?.charge(to: currentPhase)
                currentPhase = min(3, currentPhase + 1)
            }
        } else {
            currentPhase = 0
            delegate?.reset()
        }
    }

    private func shouldTriggerCharge() -> Bool {
        if let ldwDate = lastChargeDate {
            let now = Date()
            let distance = ldwDate.distance(to: now)
            switch distance {
            case 1...:
                lastChargeDate = now
                return true
            default:
                return false
            }
        } else {
            lastChargeDate = Date()
            return true
        }
    }

}
