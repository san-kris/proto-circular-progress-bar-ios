//
//  ViewController.swift
//  proto-circular-progress-bar-ios
//
//  Created by Santosh Krishnamurthy on 3/13/23.
//

import UIKit

class ViewController: UIViewController {

    // use shape layer to draw a circle
    let shapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        // Get the center point of the view
        let center = view.center
        
        // Create a track layer
        // Draw a circular path for track later
        let trackLayer = CAShapeLayer()
        // set start angle to top by - .pi/2
        let circulartTrackPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -(CGFloat.pi / 2), endAngle: CGFloat.pi*2, clockwise: true)
        // Add path to shape layer
        trackLayer.path = circulartTrackPath.cgPath
        
        // Add color to brder
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        // set border width
        trackLayer.lineWidth = 10
        
        // clear the color
        trackLayer.fillColor = UIColor.clear.cgColor
        
        // relate position to end stroke. Range 0 - 1.0
        shapeLayer.strokeEnd = 1.0
        
        // Add track sublayer
        view.layer.addSublayer(trackLayer)


        // Create a new run layer
        // Draw a circular path
        // set start angle to top by - .pi/2
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -(CGFloat.pi / 2), endAngle: CGFloat.pi*2, clockwise: true)
        // Add path to shape layer
        shapeLayer.path = circularPath.cgPath
        
        // Add color to brder
        shapeLayer.strokeColor = UIColor.red.cgColor
        // set border width
        shapeLayer.lineWidth = 10
        
        // clear the color
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        // make the end of the line round
        shapeLayer.lineCap = .round
        
        // relate position to end stroke. Range 0 - 1.0
        shapeLayer.strokeEnd = 0.0
        
        // Add shape sublayer
        view.layer.addSublayer(shapeLayer)
        
        // Add a Tap gesturetoo view
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))

    }
    
    @objc private func handleTap() -> Void {
        print("attempting animate")
        
        // Create a BasicAnimation object with KeyPath. Key name same as variable name
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // set the to value of the animation
        basicAnimation.toValue = 1.0
        // run the animation slowly. default is 0
        basicAnimation.duration = 1
        
        // animation is removed at the end. If we want to keep the animation
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        
        // Add animation to layer
        shapeLayer.add(basicAnimation, forKey: "notImpoortant")
    }

    

}

