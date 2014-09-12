//
//  ViewController.swift
//  FeetAnimationTest
//
//  Created by Jeff Gayle on 9/8/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

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
        self.overlayVC = self.storyboard!.instantiateViewControllerWithIdentifier("overlayVC") as OverlayViewController
        
        
        self.addChildViewController(self.overlayVC)
        
    }
    
    @IBAction func showOverlayButton(sender: AnyObject) {
        
        self.overlayVC.view.frame = CGRect(x: self.mapview.frame.origin.x, y: self.mapview.frame.origin.y, width: self.mapview.frame.width, height: self.mapview.frame.height)
        self.overlayVC.view.bounds = CGRect(x: self.mapview.frame.origin.x, y: self.mapview.frame.origin.y, width: self.mapview.frame.width, height: self.mapview.frame.height)
        self.overlayVC.view.clipsToBounds = true
        self.overlayVC.view.backgroundColor = UIColor.clearColor()
        
//        var sourcePoint = CLLocationCoordinate2D(latitude: nf.numberFromString(self.destinationLat.text)!, longitude: nf.numberFromString(self.sourceLong.text)!)
//
//        var destPoint = CLLocationCoordinate2D(latitude: nf.numberFromString(self.destinationLat.text)!, longitude: nf.numberFromString(self.destinationLong.text)!)
        
//        var sourcePoint = CLLocationCoordinate2D(latitude: 47.620506, longitude: -122.349277)
        var destPoint = CLLocationCoordinate2D(latitude: 47.6235481, longitude: -122.336212)
//        var safecoPoint = CLLocationCoordinate2D(latitude: 47.591351, longitude: -122.332271)
//        var quadrant3 = CLLocationCoordinate2D(latitude: 47.650000, longitude: -122.37000)
//        var quadrant4 = CLLocationCoordinate2D(latitude: 47.600000, longitude: -122.37000)
//        
//        var convertedSource = self.convertCLLocationCoordinate(sourcePoint)
//        var convertedDestination = self.convertCLLocationCoordinate(destPoint)
//        var convertedSafeco = self.convertCLLocationCoordinate(safecoPoint)
//        var convertedQuadrant3 = self.convertCLLocationCoordinate(quadrant3)
//        var convertedQuadrant4 = self.convertCLLocationCoordinate(quadrant4)
//        
//        self.overlayVC.source = convertedSource
//        self.overlayVC.destination = convertedDestination
//        self.overlayVC.safeco = convertedSafeco
//        self.overlayVC.quadrant3 = convertedQuadrant3
//        self.overlayVC.quadrant4 = convertedQuadrant4
        
        //MARK: GooglePlacesSearch
        var google = GooglePlaces()
        var searchEngine = MapSearchEngine()

        var mapItems = [MKMapItem]()
        google.search(destPoint, radius: 1000, query: "bar") { (items, errorDescription) -> Void in
            var error : NSError?
            if error != nil {
                println(errorDescription)
            } else {
                var item0 = items![0]
                var item1 = items![1]
                var item2 = items![2]
                var coord0 = item0.placemark.coordinate
                var coord1 = item1.placemark.coordinate
                var coord2 = item2.placemark.coordinate
                
                var point0 = self.convertCLLocationCoordinate(coord0)
                var point1 = self.convertCLLocationCoordinate(coord1)
                var point2 = self.convertCLLocationCoordinate(coord2)
                
                self.overlayVC.source = point0
                self.overlayVC.destination = point1
                self.overlayVC.safeco = point2
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.view.addSubview(self.overlayVC.view)
                })

            }
        }
        
        

    }
    
    func googlePlacesSearchResult(_: [MKMapItem]) {
        
    }
    
    func convertCLLocationCoordinate(coordinate: CLLocationCoordinate2D) -> CGPoint {
        return self.mapview.convertCoordinate(coordinate, toPointToView: self.view)
    }
    
    


}

