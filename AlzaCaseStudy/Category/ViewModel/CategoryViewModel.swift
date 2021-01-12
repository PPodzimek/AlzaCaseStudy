//
//  CategoryViewModel.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 07.01.2021.
//

import Foundation
import RxSwift
import RxCocoa



class CategoryViewModel {
    
    public enum CategoryError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public var navigationStack: [String] = []
    public var allowRemoval: Bool = true
    
    public let homePageModel : PublishSubject<[HomePage]> = PublishSubject()
    public let sateliteModel : PublishSubject<[Satelite]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<CategoryError> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    
    public func requestHomePage() {
        
        self.loading.onNext(true)
        
        APIManager.request(url: "https://www.alza.cz/api/catalog/v1/homePage/userNavigation", method: .get, parameters: nil, completion: { (result) in
            
            self.loading.onNext(false)
            
            switch result {
            case .success(let returnJson) :
                let homePageModel = returnJson["sections"].arrayValue.compactMap { return HomePage(data: try! $0.rawData()) }

                self.homePageModel.onNext(homePageModel)

            case .failure(let failure) :
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
    
    public func requestSatelite(url: String) {
        
        self.loading.onNext(true)
        
        APIManager.request(url: url, method: .get, parameters: nil, completion: { (result) in
            
            self.loading.onNext(false)
            
            switch result {
            case .success(let returnJson) :

                let sateliteModel = returnJson["value"].arrayValue.compactMap { return Satelite(data: try! $0.rawData()) }

                self.sateliteModel.onNext(sateliteModel)
            
            case .failure(let failure) :
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
