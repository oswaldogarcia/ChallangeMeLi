//
//  Int+extension.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 14/10/21.
//

import Foundation


extension Int {
    
    /// This function convert a `Int` to  `String` of a Number with a Colombian
    /// currency format
    ///
    /// Usage:
    ///
    ///        let intValue = 2000
    ///        intValue.asCurrencyString()
    ///
    ///        // $ 2.000
    ///
    /// - Returns: `String `  Colombian currency format
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
