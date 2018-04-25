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
    
    fileprivate var manager: HomeManager!
    fileprivate var mapView: GMSMapView!
    
    //MARK:- App Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private Method
    func setupUI(){
        
        self.title = "PSI READINGS"
        
        let camera = GMSCameraPosition.camera(withLatitude: Constants.SingaporeLocation.latitude.rawValue, longitude: Constants.SingaporeLocation.longitude.rawValue, zoom: 10.4) // Singapore
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = self.mapView
        self.mapView.delegate = self
        
        self.manager = HomeManager.init()
        self.manager.delegate = self
    }
    
    func addMarkersOnMap(){
        
        let path = GMSMutablePath()
        for pins in self.manager.location_array {
            let coordinates = CLLocationCoordinate2D(latitude: pins.lat, longitude: pins.lng)
            
            let marker = GMSMarker()
            marker.position = coordinates
            marker.icon = UIImage(named: "pin")
            marker.title = pins.name?.uppercased()
            marker.snippet = self.manager.setupMarkerDescription(pins: pins)
            marker.appearAnimation = GMSMarkerAnimation.pop
            
            marker.map = mapView
            path.add(coordinates)
        }
    }
    
    //create custom info window
    func showMarkerDetailsView(marker: GMSMarker) -> UIView {
        
        let markerView = UINib(nibName: "MarkerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MarkerView
        markerView.labelName.text = marker.title
        markerView.labelInfo.text = marker.snippet
        
        return markerView
    }
    
}


//MARK:- GMSMapViewDelegate
extension HomeViewController {
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return self.showMarkerDetailsView(marker: marker)
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        self.mapView.selectedMarker = nil
    }
}

//MARK:- HomeViewController Protocol Method
extension HomeViewController : HomeManagerDelegate {
    
    @objc internal func didUpdateHomeMarkers() {
        self.addMarkersOnMap()
    }
    
    @objc internal func didUpdateErrorWithAlert( error: String){
        //show error
    }
}
