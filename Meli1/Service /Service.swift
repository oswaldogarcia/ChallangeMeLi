//
//  Service.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 11/10/21.
//

import Foundation
import Moya
import RxSwift
import Alamofire
import UIKit

// MARK: - Service Layer
/// This service layer use the  Framework Moya to do the service calls.
///
/// `Documentation:`
///  https://github.com/Moya/Moya#readme
///  https://github.com/Moya/Moya/blob/master/docs/RxSwift.md


let provider = MoyaProvider<Service>()
var disposeBag = DisposeBag()

enum Service {
    case searchProducts(parameters:[String : Any])
    case getProductItem(parameters:[String : Any])
}

// MARK: - TargetType Protocol Implementation
extension Service: TargetType {
    
        
    /// base API url
    var baseURL: URL { URL(string: "https://api.mercadolibre.com")! } // Is set Colombia (MCO) as default site
    
    
    // path of each endpoint
    var path: String {
        switch self {
            
        case .searchProducts(_):
            return "/sites/MCO/search"
        case .getProductItem(_):
            return "/items"
            
        }
        
    }
    
    
    var method: Moya.Method {
        switch self {
        case .searchProducts(_),.getProductItem(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchProducts(let parameters),.getProductItem(let parameters):
            return .requestParameters(parameters:parameters, encoding: URLEncoding.queryString)
        
        }
        
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    /// This function call a endpoint and returns a `Observable<T>`.
    ///
    /// - Warning: The returned string is not localized.
    ///
    /// Usage:
    ///
    ///     Service.requestService(service:
    ///      .searchProduct(parameters:parameters),
    ///       model:ResultModel())
    ///
    /// - Parameter service: Service case of the endpoint to be called.
    /// - Parameter model: Model type expected in the call.
    ///
    /// - Returns: A `Observable<T>` when T will be of the kind of Model required.
    static func requestService<T: Codable>(service:Service,model:T) -> Observable<T> {
        
        return Observable<T>.create { (observer) -> Disposable in
            
            // doing the request with Moya Provider
            provider.rx.request(service).subscribe { result in
                switch result {
                case let .success(response):
                    print("|Service layer| URL requested: \(response.request!)")
                    switch response.statusCode {
                    case 200...299:
                        if let model = try? response.map(T.self, using: JSONDecoder.init(), failsOnEmptyData: false) {
                            observer.onNext(model)
                            observer.onCompleted()
                        }else {
                            print("Error: Something fail creating the model")
                            UIApplication.shared.activityStopAnimating()
                        }
                    default:
                        if let model = try? response.map(RequestErrorModel.self, using: JSONDecoder.init(), failsOnEmptyData: false) {
                            UIApplication.shared.activityStopAnimating()
                            UIApplication.shared.showErrorAlert(model.message ?? "",title: model.error ?? "Error")
                            
                        }else {
                            print("Error: Something fail creating the error model")
                            UIApplication.shared.activityStopAnimating()
                        }
                        
                        print("Error: \(response.statusCode)")
                    }
                        
                    
                case let .failure(error):
                    UIApplication.shared.activityStopAnimating()
                    UIApplication.shared.showErrorAlert("Lo sentimos, hubo un error de conexión")
                    
                    print(error.localizedDescription)
                    //observer.onError(error)
                    //observer.onCompleted()
                }
            }.disposed(by: disposeBag)
            
            return Disposables.create {}
        }
    }
}


