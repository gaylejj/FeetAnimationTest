//
//  OverlayViewController.swift
//  FeetAnimationTest
//
//  Created by Jeff Gayle on 9/8/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import UIKit
import QuartzCore

class OverlayViewController: UIViewController {
    
    @IBOutlet weak var animatingView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.drawPath()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawPath() {
        let point1 = CGPoint(x: 100, y: 100)
        let point2 = CGPoint(x: 140, y: 120)
        let point3 = CGPoint(x: 180, y: 140)
        let point4 = CGPoint(x: 220, y: 160)
        let point5 = CGPoint(x: 260, y: 180)
        
        var points = [point1, point2, point3, point4, point5]
        var trackPath = self.drawPathWithPoints(points)
        
        var track = CAShapeLayer()
        track.path = trackPath.CGPath
        track.strokeColor = UIColor.clearColor().CGColor
        track.fillColor = UIColor.clearColor().CGColor
        track.lineWidth = 3.0
        self.view.layer.addSublayer(track)
        
        var footImage = UIImage(named: "humanLeftFoot18px")
        var newFootImage = UIImage(CGImage: footImage.CGImage, scale: 1, orientation: UIImageOrientation.DownMirrored)

        var foot = CALayer()
        foot.bounds = CGRectMake(0, 0, 8, 8)
        foot.position = CGPointMake(20, 20)
        foot.contents = newFootImage.CGImage
        self.view.layer.addSublayer(foot)
        
        var animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = trackPath.CGPath
        animation.duration = 10
        animation.repeatCount = 100
        animation.rotationMode = kCAAnimationRotateAuto
        foot.addAnimation(animation, forKey: "walk")
        
    }
    
    func drawPathWithPoints(points: [CGPoint]) -> UIBezierPath {
        let source = points[0]
        let destination = points.last
        
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(source)
        
        for i in 1..<points.count {
            let offset = CGFloat(arc4random_uniform(100))
            
            if i % 2 == 0 {
                bezierPath.addCurveToPoint(points[i], controlPoint1: CGPointMake(points[i].x, points[i].y + offset), controlPoint2: CGPointMake(points[i].x, points[i].y + offset))
            } else {
                bezierPath.addCurveToPoint(points[i], controlPoint1: CGPointMake(points[i].x, points[i].y - offset), controlPoint2: CGPointMake(points[i].x, points[i].y - offset))
            }


        }
        
        return bezierPath
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
