// Playground - noun: a place where people can play

import UIKit

class Rotation {
    
    func angleBetweenTwoPoints(point1: CGPoint, point2: CGPoint) -> (transform: CGAffineTransform, quadrant: Int)   {
        let piMultiplier = 180 / M_PI
        
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
    
    var convertedSource = CGPointMake(21.277160980034022, 189.58219527524398)
    var convertedDestination = CGPointMake(21.345389957792555, 189.55862518942072)
    var convertedSafeco = CGPointMake(21.365970929958351, 189.80801768605767)
    var convertedQuadrant3 = CGPointMake(21.168939846770414, 189.35361893814402)
    var convertedQuadrant4 = CGPointMake(21.168939846770414, 189.74103928685344)
    
    
}

var rotation = Rotation()
var points = [rotation.convertedDestination, rotation.convertedSource, rotation.convertedSafeco, rotation.convertedQuadrant3, rotation.convertedQuadrant4]

for i in 0..<points.count - 1 {
    var tuple = rotation.angleBetweenTwoPoints(points[i], point2: points[i+1])
    println(tuple.transform)
}




