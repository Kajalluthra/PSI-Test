//
//  LoadingView.swift
//  PSITest
//
//  Created by Kajal on 25/4/2018.
//  Copyright © 2018 Kajal. All rights reserved.
//

import Foundation
import UIKit

class LoadingView : UIView {
    
    class func newInstance() -> LoadingView {
        let nibs = Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)! as [AnyObject]
        let loadingScreen = nibs.first as! LoadingView
        
        return loadingScreen
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK:- Handlers
    func show() {
        let window = UIApplication.shared.keyWindow!
        self.frame = window.frame
        
        self.alpha = 0.0
        window.addSubview(self)
        UIView.animate(withDuration: Constants.loadingAnimation) { () -> Void in
            self.alpha = 1.0
        }
    }
    
    func hide() {
        UIView.animate(withDuration: Constants.loadingAnimation, animations: { () -> Void in
            self.alpha = 0.0
        }, completion: { (completion) -> Void in
            self.removeFromSuperview()
        })
    }
    
}
