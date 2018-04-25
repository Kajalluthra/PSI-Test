//
//  PSIModel.swift
//  PSITest
//
//  Created by Kajal on 25/4/2018.
//  Copyright © 2018 Kajal. All rights reserved.
//

import Foundation
import UIKit

class PSIModel: NSObject {
    
    var name: String? = ""
    var lat: Double! = 0.0
    var lng: Double! = 0.0
    
    convenience init(info: AnyObject) {
        self.init()
        
        let nameString: String? = info.value(forKey: "name") as? String
        if nameString != nil{
            self.name = nameString
        }
        
        let latitude: Double? = info.value(forKeyPath:"label_location.latitude") as? Double
        if latitude != nil{
            self.lat = latitude
        }
        
        let longitude: Double? = info.value(forKeyPath:"label_location.longitude") as? Double
        if longitude != nil{
            self.lng = longitude
        }
    }
    
}

class PSIItems: NSObject {
    
    var timeStamp: String!
    var readings : NSDictionary?
    
    override init() {
        timeStamp = ""
        readings = NSDictionary()
    }
    
    convenience init(info: AnyObject) {
        self.init()
        
        let timestamp: String? = info.value(forKey: "timestamp") as? String
        if timestamp != nil{
            self.timeStamp = timestamp
        }
        
        if let readings = info.value(forKey: "readings") as? NSDictionary{
            self.readings = readings
        }
    }
    
}
