//
//  APIManager.swift
//  PSITest
//
//  Created by Kajal on 25/4/2018.
//  Copyright © 2018 Kajal. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    class func shared() -> APIManager {
        return APIManager()
    }
    
    // MARK:- Reachability
    private class Connectivity {
        class func isConnectedToInternet() ->Bool {
            return NetworkReachabilityManager()!.isReachable
        }
    }
    
    // MARK:- API Method
    func getPSIData(completed:@escaping (_ success: Bool, _ response: Any?, _ error: String?) -> Void)  {
        
        if !Connectivity.isConnectedToInternet() {
            completed(false, nil, Constants.APIErrors.noInterent.rawValue)
            return
        }
        
        let urlString = Constants.baseURL + "/" + Constants.version + "/environment/psi"
        Alamofire.request( urlString,
                           method: HTTPMethod.get,
                           parameters: nil,
                           encoding: URLEncoding.default,
                           headers: nil).validate().responseJSON { response in
                            
                            if response.result.isSuccess {
                                if let json = response.result.value as? [String: Any] {
                                    let dicJson = json as NSDictionary
                                    completed(true, dicJson, nil)
                                }
                            } else  {
                                if let statusCode = response.response?.statusCode,
                                    let reason = Constants.APIFailureReason(rawValue: statusCode) {
                                    completed(false, nil, reason.localizedDescription)
                                } else {
                                    completed(false, nil, Constants.APIErrors.somethingWrong.rawValue)
                                }
                            }
                            
        }
        
    }//end
    
}
