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
    
    var timer : NSTimer!
    var imageView : UIImageView!
    var points = [CGPoint]()
    var pointNumber = 0
    var imageViewArray = [UIImageView]()
    
    var source: CGPoint!
    var destination: CGPoint!
    var safeco : CGPoint!
    var rotation : CGAffineTransform!
    var quadrant : Int!
    
    
    @IBOutlet weak var animatingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let point1 = CGPointMake(100, 300)
//        let point2 = CGPointMake(100, 200)
//        let point3 = CGPointMake(200, 100)
//        self.points.append(point1)
//        self.points.append(point2)
//        self.points.append(point3)
        


        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.points.append(self.source)
        self.points.append(self.destination)

        self.animatePathBetweenTwoPoints(self.points[0], destination: self.points[1])
        
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animatePathBetweenTwoPoints(source: CGPoint, destination: CGPoint) {
        let leftFoot = UIImage(named: "humanLeftFoot18pxStraight")
        self.imageView = UIImageView()
        self.imageView.image = leftFoot
        self.imageView.frame = CGRectMake(source.x, source.y - 60, 10, 10)
        self.imageViewArray.append(self.imageView)
        self.view.addSubview(self.imageView)
        
        var tuple = self.angleBetweenTwoPoints(source, point2: destination)
        self.rotation = tuple.transform
        self.quadrant = tuple.quadrant
        
        self.viewAnimation(destination)
    }
    
    func viewAnimation(destination: CGPoint) {
        UIView.animateWithDuration(10, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.imageView.frame = CGRect(x: destination.x, y: destination.y - 60, width: self.imageView.frame.width, height: self.imageView.frame.height)
            self.imageView.hidden = true

            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "getPoint", userInfo: nil, repeats: true)
        }) { (success) -> Void in
            self.timer.invalidate()
            self.animatePathBetweenTwoPoints(self.source, destination: self.safeco)

        }
    }
    
    func getPoint() {
        var currentRect = self.imageView.layer.presentationLayer().frame as CGRect
        if let lastImageView = self.imageViewArray.last {
            let distanceBetweenX = abs(currentRect.origin.x - lastImageView.frame.origin.x)
            let distanceBetweenY = abs(currentRect.origin.y - lastImageView.frame.origin.y)
            
            if distanceBetweenX > 5 || distanceBetweenY > 5 {
                if self.pointNumber % 2 == 0 {
                    self.addLeftFootImage(CGPointMake(currentRect.origin.x, currentRect.origin.y))
                } else {
                    self.addRightFootImage(CGPointMake(currentRect.origin.x, currentRect.origin.y))
                }
                self.pointNumber++
            }
        }
    }
    
    func addLeftFootImage(point: CGPoint) {
        let leftFoot = UIImage(named: "humanLeftFoot18pxStraight")
        let imageView = UIImageView(image: leftFoot)
//        imageView.frame = CGRectMake(point.x, point.y , 10, 10)
        switch self.quadrant {
        case 1:
            imageView.frame = CGRectMake(point.x + 5, point.y - 5, 10, 10)
        case 2:
            imageView.frame = CGRectMake(point.x - 3, point.y - 5, 10, 10)
            //TODO: Values for 3/4
        case 3:
            imageView.frame = CGRectMake(point.x - 3, point.y - 3, 10, 10)
        case 4:
            imageView.frame = CGRectMake(point.x + 3, point.y - 3, 10, 10)
        default:
            imageView.frame = CGRectMake(point.x, point.y, 10, 10)
        }
        imageView.transform = self.rotation!
        self.imageViewArray.append(imageView)

        self.view.addSubview(imageView)
    }
    
    func addRightFootImage(point: CGPoint) {
        let rightFoot = UIImage(named: "humanRightFoot18pxStraight")
        let imageView = UIImageView(image: rightFoot)
//        imageView.frame = CGRectMake(point.x + 3, point.y, 10, 10)
        switch self.quadrant {
        case 1:
            imageView.frame = CGRectMake(point.x, point.y, 10, 10)
        case 2:
            imageView.frame = CGRectMake(point.x, point.y, 10, 10)
            //TODO: Values for 3/4
        case 3:
            imageView.frame = CGRectMake(point.x - 3, point.y - 3, 10, 10)
        case 4:
            imageView.frame = CGRectMake(point.x + 3, point.y - 3, 10, 10)
        default:
            imageView.frame = CGRectMake(point.x, point.y, 10, 10)
        }

        imageView.transform = self.rotation!

        
        

        self.imageViewArray.append(imageView)
        
        self.view.addSubview(imageView)
    }
    
    func angleBetweenTwoPoints(point1: CGPoint, point2: CGPoint) -> (transform: CGAffineTransform, quadrant: Int)   {
        let piMultiplier = 180 / M_PI
//        var angle : CGFloat = abs(atan2(0 - point1.y, 0 - point1.x))
        var lowerYAngle : CGFloat = abs(atan2(point2.y - point1.y, point2.x - point1.x))
        var higherYAngle : CGFloat = atan2(point2.x - point1.x, point2.y - point1.y)
//        var degreeAngle = angle * CGFloat(piMultiplier)
        var lowerYDegreeAngle = lowerYAngle * CGFloat(piMultiplier)
        var higherYDegreeAngle = higherYAngle * CGFloat(piMultiplier)
        
        
        var dx = point1.x - point2.x
        var dy = point1.y - point2.y

        var rotationTransform = CGAffineTransformIdentity

        if point1.x > point2.x && point1.y > point2.y {
            var angle_X_Y = atan2(dx, dy)
            var degreeAngle_X_Y = angle_X_Y * CGFloat(piMultiplier)
            rotationTransform = CGAffineTransformMakeRotation(degreeAngle_X_Y)
            return (rotationTransform, 4)
            
        } else if point1.x < point2.x && point1.y < point2.y {
            var angleXY = atan2(-dx, -dy)
            var degreeAngleXY = angleXY * CGFloat(piMultiplier)
            rotationTransform = CGAffineTransformMakeRotation(degreeAngleXY)
            return (rotationTransform, 1)
            
        } else if point1.x > point2.x && point1.y < point2.y {
            var angle_XY = atan2(dx, -dy)
            var degreeAngle_XY = angle_XY * CGFloat(piMultiplier)
            rotationTransform = CGAffineTransformMakeRotation(degreeAngle_XY)
            return (rotationTransform, 3)
            
        } else {
            var angleX_Y = atan2(-dx, dy)
            var degreeAngleX_Y = angleX_Y * CGFloat(piMultiplier)
            rotationTransform = CGAffineTransformMakeRotation(degreeAngleX_Y)
            return (rotationTransform, 2)
        }
    }
    
//    let fraction: Double = -140/180
    // 90/180 is flipped
    
//    let piMultiplier = M_PI * fraction
//    let rotate = CGAffineTransformMakeRotation(CGFloat(piMultiplier))

    //        imageView.transform = rotate
    
//    angle / 180.0 * M_PI
    
    //MARK: Bezier Path Functions
    
    /*
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
        track.strokeColor = UIColor.redColor().CGColor
        track.lineDashPattern = [3, 2]
        track.fillColor = UIColor.clearColor().CGColor
        track.lineWidth = 3.0
        track.lineJoin = kCALineJoinRound
        self.view.layer.addSublayer(track)
        
        var footImage = UIImage(named: "humanLeftFoot18px")
        var newFootImage = UIImage(CGImage: footImage.CGImage, scale: 1, orientation: UIImageOrientation.Right)
        
        var rightFootImage = UIImage(named: "humanRightFoot18px")
        var newRightFootImage = UIImage(CGImage: rightFootImage.CGImage, scale: 1, orientation: UIImageOrientation.LeftMirrored)
        
        var leftFoot = CALayer()
        leftFoot.bounds = CGRectMake(0, 0, 8, 8)
        //        leftFoot.position = CGPointMake(20, 20)
        leftFoot.contents = newFootImage.CGImage
        self.view.layer.addSublayer(leftFoot)
        
        var animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = trackPath.CGPath
        animation.duration = 10
        animation.repeatCount = 100
        animation.rotationMode = kCAAnimationRotateAuto
        leftFoot.addAnimation(animation, forKey: "walk")
        
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
    
    */
    
    //void MyCGPathApplierFunc (void *info, const CGPathElement *element);
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
