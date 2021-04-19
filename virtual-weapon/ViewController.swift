//
//  ViewController.swift
//  virtual-weapon
//
//  Created by Ming Sun on 4/8/21.
//

import UIKit

class ViewController: UIViewController {

    let motion = Motion()
    lazy var greatSword = GreatSword(with: motion)
    let generator = UIImpactFeedbackGenerator()
    let chargeBar: [UIColor] = [.yellow, .orange, .red]
    let intensity: [CGFloat] = [0.6, 0.8, 1.0]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        greatSword.delegate = self
        greatSword.startSimulate()
    }

}


extension ViewController: GreatSwordDelegate {
    func charge(to phase: Int) {
        if phase < chargeBar.count {
            UIView.transition(with: view, duration: 0.8, options: .curveEaseIn) {
                self.view.backgroundColor = self.chargeBar[phase]
            } completion: { _ in
                self.generator.impactOccurred(intensity: self.intensity[phase])
            }
        }
    }

    func reset() {
        view.backgroundColor = .white
    }
}

