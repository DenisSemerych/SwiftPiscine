//
//  ViewController.swift
//  MoutionCube
//
//  Created by Denis SEMERYCH on 4/9/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var gravity = UIGravityBehavior()
    var animator: UIDynamicAnimator!
    var collision = UICollisionBehavior()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first, let view = touch.view as? Figure {
//            gravity.removeItem(view)
//            print("removed")
//        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for subview in self.view.subviews {
//            gravity.addItem(subview)
//            print("added")
//        }
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        let colors: [UIColor] = [.blue, .purple, .red, .black, .green, .gray, .brown, .orange, .yellow, .magenta]
        let position = sender.location(in: self.view)
        let figure = Figure(frame: CGRect(x: position.x, y: position.y, width: CGFloat(100), height: CGFloat(100)))
        let panRecognizer = UIPanGestureRecognizer(target: figure, action: #selector(figure.handlePan(recognizer:)))
        let pinchRecognizer = UIPinchGestureRecognizer(target: figure, action: #selector(figure.handlePinch(recognizer:)))
        let rotateRecognizer = UIRotationGestureRecognizer(target: figure, action: #selector(figure.handleRotation(recognizer:)))
        figure.gestureRecognizers = [panRecognizer, pinchRecognizer, rotateRecognizer]
        figure.backgroundColor = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        self.view.addSubview(figure)
        gravity.addItem(figure)
        figure.delegate = self
        collision.addItem(figure)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator.init(referenceView: self.view)
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        collision.translatesReferenceBoundsIntoBoundary = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

