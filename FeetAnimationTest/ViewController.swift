//
//  ViewController.swift
//  FeetAnimationTest
//
//  Created by Jeff Gayle on 9/8/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    var overlayVC = OverlayViewController()
    
    @IBOutlet weak var mapview: MKMapView!
    
    @IBOutlet weak var sourceLat: UITextField!
    @IBOutlet weak var sourceLong: UITextField!
    
    @IBOutlet weak var destinationLong: UITextField!
    @IBOutlet weak var destinationLat: UITextField!
    
    var nf = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapview.delegate = self
        self.setupOverlayVC()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupOverlayVC() {
        self.overlayVC = self.storyboard.instantiateViewControllerWithIdentifier("overlayVC") as OverlayViewController
        
        self.addChildViewController(self.overlayVC)
        
    }
    
    @IBAction func showOverlayButton(sender: AnyObject) {
        
        self.overlayVC.view.frame = CGRect(x: self.mapview.frame.origin.x, y: self.mapview.frame.origin.y, width: self.mapview.frame.width, height: self.mapview.frame.height)
        self.overlayVC.view.backgroundColor = UIColor.clearColor()
        
//        var sourcePoint = CLLocationCoordinate2D(latitude: nf.numberFromString(self.destinationLat.text)!, longitude: nf.numberFromString(self.sourceLong.text)!)
//
//        var destPoint = CLLocationCoordinate2D(latitude: nf.numberFromString(self.destinationLat.text)!, longitude: nf.numberFromString(self.destinationLong.text)!)
        
        var sourcePoint = CLLocationCoordinate2D(latitude: 47.620506, longitude: -122.349277)
        var destPoint = CLLocationCoordinate2D(latitude: 47.6235481, longitude: -122.336212)
        var safecoPoint = CLLocationCoordinate2D(latitude: 47.591351, longitude: -122.332271)
        
        var convertedSource = self.convertCLLocationCoordinate(sourcePoint)
        var convertedDestination = self.convertCLLocationCoordinate(destPoint)
        var convertedSafeco = self.convertCLLocationCoordinate(safecoPoint)
        
        self.overlayVC.source = convertedSource
        self.overlayVC.destination = convertedDestination
        self.overlayVC.safeco = convertedSafeco
        self.view.addSubview(self.overlayVC.view)

    }
    
    func convertCLLocationCoordinate(coordinate: CLLocationCoordinate2D) -> CGPoint {
        return self.mapview.convertCoordinate(coordinate, toPointToView: self.view)
    }
    
    


}

