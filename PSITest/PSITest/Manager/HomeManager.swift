//
//  HomeManager.swift
//  PSITest
//
//  Created by Kajal on 25/4/2018.
//  Copyright © 2018 Kajal. All rights reserved.
//

import Foundation
import UIKit

@objc protocol HomeManagerDelegate: class {
    
    func didUpdateHomeMarkers()
    func didUpdateErrorWithAlert( error: String)
}

class HomeManager: NSObject {
    
    weak var delegate: HomeManagerDelegate?
    
    let apiManager = APIManager.shared()
    let loadingInstance = LoadingView.newInstance()
    
    var location_array: [PSIModel] = [PSIModel]()
    var items_array: [PSIItems] = [PSIItems]()
    
    override init() {
        super.init()
        requestToPSIApi()
    }
    
    // MARK:- Private Methods
    func requestToPSIApi() {
        
        self.loadingInstance.show()
        apiManager.getPSIData(){(success, response, error) in
            if success {
                let dictResponse = response as! NSDictionary
                let arraylocations = dictResponse.value(forKey: "region_metadata") as! NSArray
                for loc in arraylocations{
                    let dictMV = loc as! NSDictionary
                    let model = PSIModel(info: dictMV)
                    self.location_array.append(model)
                }
                let arrayitems = dictResponse.value(forKey: "items") as! NSArray
                for item in arrayitems{
                    let dictMV = item as! NSDictionary
                    let model = PSIItems(info: dictMV)
                    self.items_array.append(model)
                }
                self.handleListResponse()
                
            } else {
                self.showAlert(errorList: error!.description)
            }
            self.loadingInstance.hide()
        }
        
    }//end
    
    func setupMarkerDescription(pins: PSIModel) -> String {
        
        var snippetText = "o3_sub_index: \(self.items_array[0].readings?.value(forKeyPath: String(format:"o3_sub_index.%@",pins.name!) ) ?? "")\n"
        snippetText += "pm10_twenty_four_hourly: \(self.items_array[0].readings?.value(forKeyPath: String(format:"pm10_twenty_four_hourly.%@",pins.name!) ) ?? "")\n"
        snippetText += "pm10_sub_index: \(self.items_array[0].readings?.value(forKeyPath: String(format:"pm10_sub_index.%@",pins.name!) ) ?? "")\n"
        snippetText += "co_sub_index: \(self.items_array[0].readings?.value(forKeyPath: String(format:"co_sub_index.%@",pins.name!) ) ?? "")\n"
        snippetText += "pm25_twenty_four_hourly: \(self.items_array[0].readings?.value(forKeyPath: String(format:"pm25_twenty_four_hourly.%@",pins.name!) ) ?? "")\n"
        snippetText += "so2_sub_index: \(self.items_array[0].readings?.value(forKeyPath: String(format:"so2_sub_index.%@",pins.name!) ) ?? "")\n"
        snippetText += "co_eight_hour_max: \(self.items_array[0].readings?.value(forKeyPath: String(format:"co_eight_hour_max.%@",pins.name!) ) ?? "")\n"
        snippetText += "no2_one_hour_max: \(self.items_array[0].readings?.value(forKeyPath: String(format:"no2_one_hour_max.%@",pins.name!) ) ?? "")\n"
        snippetText += "so2_twenty_four_hourly: \(self.items_array[0].readings?.value(forKeyPath: String(format:"so2_twenty_four_hourly.%@",pins.name!) ) ?? "")\n"
        snippetText += "pm25_sub_index: \(self.items_array[0].readings?.value(forKeyPath: String(format:"pm25_sub_index.%@",pins.name!) ) ?? "")\n"
        snippetText += "psi_twenty_four_hourly: \(self.items_array[0].readings?.value(forKeyPath: String(format:"psi_twenty_four_hourly.%@",pins.name!) ) ?? "")\n"
        snippetText += "o3_eight_hour_max: \(self.items_array[0].readings?.value(forKeyPath: String(format:"o3_eight_hour_max.%@",pins.name!) ) ?? "")\n"
        
        return snippetText
    }
    
    
    // MARK:- Handlers
    fileprivate func handleListResponse() {
        self.delegate?.didUpdateHomeMarkers()
    }
    
    fileprivate func showAlert(errorList:String) {
        self.delegate?.didUpdateErrorWithAlert( error: errorList)
    }
    
}
