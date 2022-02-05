//
//  TouchMoveView.swift
//  Ruller
//
//  Created by Serhii Londar on 05.02.2022.
//

import UIKit

class TouchMoveView: UIView {
    var touchesMoved: ((CGPoint) -> Void)?
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard let touch = touches.first else { return }
        guard let superview = superview else { return }
        
        let touchCoordinates = touch.location(in: superview)
        let previousCoordinate = touch.previousLocation(in: superview)
        
        let deltaX = touchCoordinates.x - previousCoordinate.x
        let deltaY = touchCoordinates.y - previousCoordinate.y

        let offset = CGPoint(x: deltaX, y: deltaY)
        
        touchesMoved?(offset)
    }
}
