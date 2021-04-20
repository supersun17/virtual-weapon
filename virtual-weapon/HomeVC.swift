//
//  HomeVC.swift
//  virtual-weapon
//
//  Created by Ming Sun on 4/8/21.
//

import UIKit

class HomeVC: UIViewController {
    private(set) lazy var gripButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Grip", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    let motion = Motion()
    lazy var greatSword = GreatSword(with: motion)
    let generator = UIImpactFeedbackGenerator()
    let chargeBar: [UIColor] = [.yellow, .orange, .red]
    let intensity: [CGFloat] = [0.6, 0.8, 1.0]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        setUpActions()

        greatSword.delegate = self
        greatSword.startSimulate()
    }

    private func setUpUI() {
        view.addSubview(gripButton)
        var constraints = [NSLayoutConstraint]()
        constraints += [
            gripButton.heightAnchor.constraint(equalToConstant: 60.0),
            gripButton.widthAnchor.constraint(equalTo: gripButton.heightAnchor),
            gripButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gripButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setUpActions() {
        gripButton.addTarget(self, action: #selector(handleGrip), for: .valueChanged)
    }
    @objc
    private func handleGrip(btn: UIButton) {
        print("Pressing?")
    }

}


extension HomeVC: GreatSwordDelegate {
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

