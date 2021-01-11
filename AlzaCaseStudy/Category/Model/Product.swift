//
//  Product.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 10.01.2021.
//

import Foundation


struct ProductSelf: Codable {
    
    let productUrl: String?
    let appLink: String?
    
    enum CodingKeys: String, CodingKey {
        case productUrl = "href"
        case appLink
        
    }
    
}

struct SateliteProduct: Codable {
    
    let productSelf: ProductSelf?
    let id: Int?
    let name: String?
    let imgUrl: String?
    let price: String?
    let availability: String?
    let ratingStars: Double?
    
    enum CodingKeys: String, CodingKey {
        case productSelf = "self"
        case id
        case name
        case imgUrl
        case price
        case availability
        case ratingStars
    }
    
}

struct ProductsSelf: Codable {
    
    let productsSelfUrl: String?
    let appLink: String?
    
    enum CodingKeys: String, CodingKey {
        case productsSelfUrl = "href"
        case appLink
    }
    
}

struct Products: Codable {
    
    let productsSelf: ProductsSelf?
    let productsValue: [SateliteProduct]?
    
    enum CodingKeys: String, CodingKey {
        case productsSelf = "self"
        case productsValue = "value"
    }
}
