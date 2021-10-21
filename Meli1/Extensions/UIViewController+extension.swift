//
//  UIViewController+extension.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 17/10/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// This function retunrs the most top viewController 
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.keyWindow().rootViewController
        
        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }
        
        return topMostViewController
    }
    
    /// This function shows a overlay view with a started Activity Indicator
    ///
    /// Usage:
    ///
    ///     self.activityStartAnimating()
    ///
    func activityStartAnimating() {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        backgroundView.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        backgroundView.tag = 9999
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        
        self.view.addSubview(backgroundView)
    }
    
    /// This function remove a overlay view with a  Activity Indicator and stop it
    ///
    /// Usage:
    ///
    ///     self.activityStopAnimating()
    ///
    func activityStopAnimating() {
        if let background = self.view.viewWithTag(9999){
            background.removeFromSuperview()
        }
        self.view.isUserInteractionEnabled = true
    }
    
}
