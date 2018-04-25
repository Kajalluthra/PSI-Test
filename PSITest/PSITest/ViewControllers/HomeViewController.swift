//
//  ViewController.swift
//  PSITest
//
//  Created by Kajal on 25/4/2018.
//  Copyright © 2018 Kajal. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController, GMSMapViewDelegate {

    fileprivate var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUI()
    }

    //MARK:- Private Method
    func setupUI(){
        
        self.title = "PSI READINGS"
        
        let camera = GMSCameraPosition.camera(withLatitude: Constants.SingaporeLocation.latitude.rawValue, longitude: Constants.SingaporeLocation.longitude.rawValue, zoom: 10.4) // Singapore
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = self.mapView
        self.mapView.delegate = self
  
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK:- GMSMapViewDelegate
extension HomeViewController {
    /*
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
    }*/
}
