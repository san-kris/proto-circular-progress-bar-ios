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
    var pulsatingLayer: CAShapeLayer?
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()
    
    // set the font color of time and battery in status bar
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    private func setupNotificationObserver(){
        // Add an observer that will benootified when app returns to foreground
        // need to declate a @objc function and provide it as #selector input
        // Notification type = UIApplication.willEnterForegroundNotification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleReturnToForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        
    }
    
    @objc func handleReturnToForeground(){
        print("Foreground handler called")
        animatePulsatingLayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // minimizing the background will disable the animation
        // we need to be nootified when application moves to foreground and add animation again
        setupNotificationObserver()
 
        view.backgroundColor = UIColor.black
        
        // Get the center point of the view
        let center = view.center

        
        // Setting up pulsating layer
        pulsatingLayer = CAShapeLayer()

        // set start angle to top by - .pi/2
        let circularPulsatingPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -(CGFloat.pi / 2), endAngle: CGFloat.pi*2, clockwise: true)

        // Add path to shape layer
        pulsatingLayer?.path = circularPulsatingPath.cgPath
        
        // Add color to brder
        pulsatingLayer?.strokeColor = UIColor.red.cgColor
        // set border width
        pulsatingLayer?.lineWidth = 10
        
        // clear the color
        pulsatingLayer?.fillColor = UIColor.yellow.cgColor
        
        // relate position to end stroke. Range 0 - 1.0
        // pulsatingLayer?.strokeEnd = 1.0
        
        //pulsatingLayer?.position = view.center

        // Add track sublayer
        view.layer.addSublayer(pulsatingLayer!)
        
        animatePulsatingLayer()
        
        
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
        
        // Add track sublayer
        view.layer.addSublayer(trackLayer)

        
        // relate position to end stroke. Range 0 - 1.0
        shapeLayer.strokeEnd = 1.0
        
        // Add track sublayer
        view.layer.addSublayer(trackLayer)
        
        
        
        
        
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center



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
    
    func animatePulsatingLayer(){
        // create an animation which changes the linewidth prooperty of the object
        let animation = CABasicAnimation(keyPath: "lineWidth")
        // add the to value
        animation.toValue = 20
        // set the duration
        animation.duration = 1
        // set the animation to run in infinite loop
        animation.repeatCount = Float.infinity
        // set the animation to reverse animate
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        // add animatioon to a layer
        pulsatingLayer?.add(animation, forKey: "pulsing")
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

