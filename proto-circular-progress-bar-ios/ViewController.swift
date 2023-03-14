//
//  ViewController.swift
//  proto-circular-progress-bar-ios
//
//  Created by Santosh Krishnamurthy on 3/13/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        // use shape layer to draw a circle
        let shapeLayer = CAShapeLayer()
        
        // Get the center point of the view
        let center = view.center
        // Draw a circular path
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        // Add path to shape layer
        shapeLayer.path = circularPath.cgPath
        
        // Add color to brder
        shapeLayer.strokeColor = UIColor.red.cgColor
        // set border width
        shapeLayer.lineWidth = 10
        
        view.layer.addSublayer(shapeLayer)
        
        

    }

    

}

