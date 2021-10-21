//
//  window+extension.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 17/10/21.
//

import Foundation
import UIKit

extension UIApplication {
    
    /// This function return the keyWindows
    func keyWindow() -> UIWindow {
        
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first ?? UIWindow()
    }
    

    /// This function shows an Alert with a error message
    ///
    /// Usage:
    ///
    ///     UIApplication.shared.
    ///     showErrorAlert(error.message ,title: error.name )
    ///
    ///
    /// - Parameter errorMessage : `String ` to idicate the error message
    /// - Parameter title: `String ` to idicate the error name
    ///
    func showErrorAlert(_ errorMessage:String,title:String = "Error"){
        let alert = UIAlertController(title:title , message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        UIApplication.shared.keyWindow().rootViewController?.getTopMostViewController()?.present(alert, animated: true, completion: nil)
    }
    
    /// This function shows a overlay view with a started Activity Indicator in the top view controller
    ///
    /// Usage:
    ///
    ///     UIApplication.shared.
    ///     activityStartAnimating()
    ///
    func activityStartAnimating()  {
        UIApplication.shared.keyWindow().rootViewController?.getTopMostViewController()?.activityStartAnimating()
    }
    
    /// This function remove a overlay view with a  Activity Indicator and stop it of the top view controller
    ///
    /// Usage:
    ///
    ///     UIApplication.shared.
    ///     activityStopAnimating()
    ///
    func activityStopAnimating() {
        UIApplication.shared.keyWindow().rootViewController?.getTopMostViewController()?.activityStopAnimating()
    }
}
