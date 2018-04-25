//
//  Constants.swift
//  PSITest
//
//  Created by Kajal on 25/4/2018.
//  Copyright © 2018 Kajal. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    static let loadingAnimation = 0.35
    static let googleKey = "AIzaSyDXCSyTi654n6HbdCSKiZhh-kfYilT3OFo"
    static let navBarColor = UIColor(red: 252.0/255.0, green: 92.0/255.0, blue: 99.0/255.0, alpha: 1.0)
    
    // HomeVC
    enum SingaporeLocation: Double {
        case latitude = 1.35735
        case longitude = 103.82
    }
    
    // API COnstants
    static let baseURL = "https://api.data.gov.sg"
    static let version = "v1"
    
    enum APIErrors: String {
        case noInterent = "No Internet Connection!"
        case somethingWrong = "Something went wrong!"
    }
    
    enum APIFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
}
