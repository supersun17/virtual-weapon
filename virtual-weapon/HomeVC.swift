//
//  HomeVC.swift
//  virtual-weapon
//
//  Created by Ming Sun on 4/8/21.
//

import UIKit

class HomeVC: UIViewController {
    private(set) lazy var gripArea: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .gray
        lbl.textAlignment = .center
        lbl.text = "GRIP"
        lbl.layer.cornerRadius = gripAreaCornerRadius
        lbl.clipsToBounds = true
        lbl.isUserInteractionEnabled = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private let gripAreaCornerRadius: CGFloat = 60.0

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
    }

    private func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(gripArea)
        var constraints = [NSLayoutConstraint]()
        constraints += [
            gripArea.heightAnchor.constraint(equalToConstant: gripAreaCornerRadius * 2.0),
            gripArea.widthAnchor.constraint(equalTo: gripArea.heightAnchor),
            gripArea.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gripArea.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setUpActions() {
        greatSword.delegate = self
        let holding = UILongPressGestureRecognizer(target: self, action: #selector(handleGrip))
        gripArea.addGestureRecognizer(holding)
    }
    @objc
    private func handleGrip(recognizer: UIGestureRecognizer) {
        switch recognizer.state {
        case .began:
            greatSword.startSimulate()
        case .cancelled, .failed, .ended:
            greatSword.stopSimulate()
        default:
            break
        }
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

