//
//  ViewController.swift
//  Ruller
//
//  Created by Serhii Londar on 18.01.2022.
//

import UIKit

class ViewController: UIViewController {
    var rullerContentView = RulerContentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleTwoFingersGesture(_ :)))
        gestureRecognizer.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc
    func handleTwoFingersGesture(_ sender: UILongPressGestureRecognizer) {
        let firstPosition = sender.location(ofTouch: 0, in: view)
        let secondPosition = sender.location(ofTouch: 1, in: view)
        
        if sender.state == .began {
            addRulerView()
            rullerContentView.set(startPosition: firstPosition, endPosition: secondPosition)
        } else if sender.state == .changed {
            rullerContentView.set(startPosition: firstPosition, endPosition: secondPosition)
        } else if sender.state == .ended {
            
        }
    }
    
    func addRulerView() {
        rullerContentView.frame = self.view.bounds
        self.view.addSubview(rullerContentView)
    }
}

extension UIView {

    /**
     Rotate a view by specified degrees

     - parameter angle: angle in degrees
     */
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = CGAffineTransform(rotationAngle: radians)
        self.transform = rotation
    }

}
