//
//  Figure.swift
//  MoutionCube
//
//  Created by Denis SEMERYCH on 4/9/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class Figure: UIView, UIGestureRecognizerDelegate {
    
    var isCycle = false
    var delegate: ViewController?
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return isCycle ? .ellipse : .rectangle
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if arc4random_uniform(2) != 0 {
            self.layer.cornerRadius = self.frame.size.width/2
            self.clipsToBounds = true
            self.isCycle = true
        }
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
       // delegate?.gravity.removeItem(self)
        let translation = recognizer.translation(in: self.superview)
        guard let view = recognizer.view else {return}
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        recognizer.setTranslation(CGPoint.zero, in: self.superview)
        //delegate?.gravity.addItem(self)
    }
    
    @objc func handlePinch(recognizer: UIPinchGestureRecognizer) {
        //delegate?.gravity.removeItem(self)
        guard let view = recognizer.view else {return}
        view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
       // delegate?.gravity.addItem(self)
    }
    
    @objc func handleRotation(recognizer: UIRotationGestureRecognizer) {
        guard let view = recognizer.view else {return}
        view.transform = view.transform.rotated(by: recognizer.rotation)
        recognizer.rotation = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

