//
//  ProductDetailViewModel.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 12.01.2021.
//

import Foundation
import RxSwift
import RxCocoa

class ProductDetailViewModel {
    
    public enum ProductDetailError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public var productDetailUrl: String = ""
    
    public let productDetailModel : PublishSubject<ProductDetail> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<ProductDetailError> = PublishSubject()
    
    public func requestProductDetail(url: String) {
        
        self.loading.onNext(true)
        
        APIManager.request(url: url, method: .get, parameters: nil, completion: { (result) in
            
            self.loading.onNext(false)
            
            switch result {
            case .success(let returnJson):

                if let productDetail = ProductDetail(data: try! returnJson["data"].rawData()) {
                    
                    self.productDetailModel.onNext(productDetail)
                    
                }
                
                                
            case .failure(let failure):
                switch failure {
                case .connectionError:
                    self.error.onNext(.internetError("Check your Internet connection."))
                case .authorizationError(let errorJson):
                    self.error.onNext(.serverMessage(errorJson["message"].stringValue))
                default:
                    self.error.onNext(.serverMessage("Unknown Error"))
                }
            }
        })
        
    }
    
}
