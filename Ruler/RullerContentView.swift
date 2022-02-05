//
//  RullerContentView.swift
//  Ruller
//
//  Created by Serhii Londar on 05.02.2022.
//

import UIKit

class RulerContentView: UIView {
    let rullerHeight: CGFloat = 20.0
    let connectorView: TouchMoveView
    
    let startView = TouchMoveView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var startPosition: CGPoint = .zero
    let endView = TouchMoveView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var endPosition: CGPoint = .zero
    
    let infoView = TouchMoveView(frame: CGRect(origin: .zero, size: CGSize(width: 150, height: 75)))
    
    init() {
        self.connectorView = TouchMoveView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: rullerHeight)))
        
        super.init(frame: .zero)
        
        addViews()
        layoutViews()
        setupViews()
        updateFrames()
        
        backgroundColor = .yellow
    }
    
    func addViews() {
        self.addSubview(connectorView)
        self.addSubview(startView)
        self.addSubview(endView)
        self.addSubview(infoView)
    }
    
    func layoutViews() {
        
    }
    
    func setupViews() {
        startView.backgroundColor = .blue
        startView.touchesMoved = { offset in
            self.set(startPosition: CGPoint(x: self.startPosition.x + offset.x, y: self.startPosition.y + offset.y))
        }
        
        connectorView.backgroundColor = .red
        connectorView.touchesMoved = {  offset in
            self.set(startPosition: CGPoint(x: self.startPosition.x + offset.x, y: self.startPosition.y + offset.y), endPosition: CGPoint(x: self.endPosition.x + offset.x, y: self.endPosition.y + offset.y))
        }
        
        endView.backgroundColor = .blue
        endView.touchesMoved = { offset in
            self.set(endPosition: CGPoint(x: self.endPosition.x + offset.x, y: self.endPosition.y + offset.y))
        }
        
        infoView.backgroundColor = .gray
        infoView.touchesMoved = {  offset in
            self.set(startPosition: CGPoint(x: self.startPosition.x + offset.x, y: self.startPosition.y + offset.y), endPosition: CGPoint(x: self.endPosition.x + offset.x, y: self.endPosition.y + offset.y))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFrames() {
        startView.center = startPosition
        endView.center = endPosition
        
        let center = CGPoint(x: (startPosition.x + endPosition.x) / 2, y: (startPosition.y + endPosition.y) / 2)
        
        connectorView.center = center
        infoView.center = center
        
        let deltaX = endPosition.x - startPosition.x
        let deltaY = endPosition.y - startPosition.y
        let width = sqrt(deltaX * deltaX + deltaY * deltaY)

        let size = CGSize(width: width, height: connectorView.bounds.height)
        connectorView.bounds = CGRect(origin: bounds.origin, size: size)
        
        let angle = atan2f(Float(deltaY), Float(deltaX))
        connectorView.transform = CGAffineTransform.identity.rotated(by: CGFloat(angle))
    }
    
    
    func set(startPosition: CGPoint) {
        self.startPosition = startPosition
        updateFrames()
    }
    
    func set(endPosition: CGPoint) {
        self.endPosition = endPosition
        updateFrames()
    }
    
    func set(startPosition: CGPoint, endPosition: CGPoint) {
        self.startPosition = startPosition
        self.endPosition = endPosition
        updateFrames()
    }
}
