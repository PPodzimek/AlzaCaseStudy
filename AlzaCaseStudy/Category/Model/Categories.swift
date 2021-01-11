//
//  Categories.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 08.01.2021.
//

import Foundation

struct CategorySelf: Codable {
    
    let categoryUrl: String?
    let appLink: String?
    
    enum CodingKeys: String, CodingKey {
        case categoryUrl = "href"
        case appLink
        
    }
    
}

struct Category: Codable {
    
    let categorySelf: CategorySelf?
    let categoryImage: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case categorySelf = "self"
        case categoryImage = "img"
        case name
    }
    
}

struct CategoriesSelf: Codable {
    
    let categoriesSelfUrl: String?
    let appLink: String?
    
    enum CodingKeys: String, CodingKey {
        case categoriesSelfUrl = "href"
        case appLink
    }
    
}

struct Categories: Codable {
    
    let categoriesSelf: CategoriesSelf?
    let categoriesValue: [Category]?
    
    enum CodingKeys: String, CodingKey {
        case categoriesSelf = "self"
        case categoriesValue = "value"
    }
    
}
