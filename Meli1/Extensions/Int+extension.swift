//
//  Int+extension.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 14/10/21.
//

import Foundation


extension Int {
    
    func asCurrencyString() -> String{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale(identifier: "es_CO")
  
        let number = NSNumber(value: self)
    
        return formatter.string(from: number) ?? ""
        
    }
    
}
