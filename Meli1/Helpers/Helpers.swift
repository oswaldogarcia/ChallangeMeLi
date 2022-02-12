//
//  Helpers.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 11/02/22.
//

import Foundation
import RxSwift

public class Helpers {
    
  
    public static let shared = Helpers()
    
    /// This Method Response a Generic Model as Observable.
    /// It is useful to manage the Mock Data.
    public func getObservableModelFromLocalJSON<T: Codable>(jsonName:String,model:T) -> Observable<T>{
        return Observable<T>.create { (observer) -> Disposable in
            
            let url = Bundle.main.url(forResource: jsonName, withExtension: "json")
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonData = try Data(contentsOf: url!)
                let model = try decoder.decode(T.self, from: jsonData)
                observer.onNext(model)
            }catch let error{
                observer.onError(error)
            }
            
            return Disposables.create {}
        }
    }
}
