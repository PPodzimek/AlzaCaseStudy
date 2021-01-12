//
//  APIManager.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 06.01.2021.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON


class APIManager {
    
    static let baseUrl = ""
    
    typealias parameters = [String: Any]
    
    enum ApiResult {
        case success(JSON)
        case failure(RequestError)
    }
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    enum RequestError: Error {
        case unknownError
        case connectionError
        case authorizationError(JSON)
        case invalidRequest
        case notFound
        case invalidResponse
        case serverError
        case serverUnavailable
    }
    
    static func request(url: String, method: HTTPMethod, parameters: parameters?, completion: @escaping (ApiResult) -> Void) {
        
        let header =  ["Content-Type": "application/x-www-form-urlencoded"]
        
        var urlRequest = URLRequest(url: URL(string: baseUrl+url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print(error)
                completion(ApiResult.failure(.connectionError))
            } else if let data = data, let responseCode = response as? HTTPURLResponse {
                
                do {
                    let responseJson = try JSON(data: data)
                    print("responseCode : \(responseCode.statusCode)")
//                    print("responseJSON : \(responseJson)")
                    
                    switch responseCode.statusCode {
                    
                    case 200:
                    completion(ApiResult.success(responseJson))
                    case 400...499:
                    completion(ApiResult.failure(.authorizationError(responseJson)))
                    case 500...599:
                    completion(ApiResult.failure(.serverError))
                    default:
                        completion(ApiResult.failure(.unknownError))
                        break
                        
                    }
                }
                
                catch let parseJSONError {
                    completion(ApiResult.failure(.unknownError))
                    print("error on parsing request to JSON : \(parseJSONError)")
                }
            }
            
        }.resume()
    }
    
}
