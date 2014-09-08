//
//  ViewController.swift
//  FeetAnimationTest
//
//  Created by Jeff Gayle on 9/8/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var overlayVC = OverlayViewController()
    
    @IBOutlet weak var mapview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        self.overlayVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.overlayVC.view.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.overlayVC.view)

    }
    
    


}

