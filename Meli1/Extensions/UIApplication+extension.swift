//
//  window+extension.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 17/10/21.
//

import Foundation
import UIKit

extension UIApplication {
    
    func keyWindow() -> UIWindow {
        
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first ?? UIWindow()
    }
    

    
    func showErrorAlert(_ errorMessage:String,title:String = "Error"){
        let alert = UIAlertController(title:title , message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        UIApplication.shared.keyWindow().rootViewController?.getTopMostViewController()?.present(alert, animated: true, completion: nil)
    }
    
    func activityStartAnimating()  {
        UIApplication.shared.keyWindow().rootViewController?.getTopMostViewController()?.activityStartAnimating()
    }
    
    func activityStopAnimating() {
        UIApplication.shared.keyWindow().rootViewController?.getTopMostViewController()?.activityStopAnimating()
    }
}
