//
//  ProductDetail.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 12.01.2021.
//

import Foundation
import RxSwift
import RxCocoa


struct ProductDetail: Codable {
    
    let name: String
    let img: String
    let price: String
    let avail: String
    
}

extension ProductDetail {
    
    init?(data: Data) {
        do {
            let result = try JSONDecoder().decode(ProductDetail.self, from: data)
            self = result
        }
        catch {
            print(error)
            return nil
        }
    }
}
