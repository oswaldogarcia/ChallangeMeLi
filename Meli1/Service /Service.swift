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


let provider = MoyaProvider<Service>()
var disposeBag = DisposeBag()

enum Service {
    case searchProduct(product:String)
}

// MARK: - TargetType Protocol Implementation
extension Service: TargetType {
    
    var baseURL: URL { URL(string: "https://api.mercadolibre.com/sites/MCO")! }
    
    var path: String {
        switch self {
       
        case .searchProduct(_):
            return "/search"
        }
    }
    
    
    var method: Moya.Method {
        switch self {
        case .searchProduct(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchProduct(let product):
            return .requestParameters(parameters:["q": product], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    
    static func requestService<T: Codable>(service:Service,model:T) -> Observable<T> {
        
        return Observable<T>.create { (observer) -> Disposable in
            
            print(service.path)
            provider.rx.request(service).subscribe { result in
                switch result {
                case let .success(response):
                    
                    
                        let path = "results"
                        
                        if let model = try? response.map(T.self, atKeyPath: path, using: JSONDecoder.init(), failsOnEmptyData: false) {
                            
                            observer.onNext(model)
                            observer.onCompleted()
                        }else {
                            print("model fail")
                        }
                    
                case let .failure(error):
                    
                    print(error)
                    observer.onError(error)
                    observer.onCompleted()
                }
            }.disposed(by: disposeBag)
            
            return Disposables.create {}
        }
    }
}


