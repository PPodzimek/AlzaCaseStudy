//
//  Satelite.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 10.01.2021.
//

import Foundation


struct Satelite: Codable {

    let itemType: String
    let categories: Categories?
    let products: Products?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case itemType
        case categories
        case products = "commodities"
        case title
    }

}

extension Satelite {

    init?(data: Data) {
        do {
            let result = try JSONDecoder().decode(Satelite.self, from: data)
            self = result
        }
        catch {
            print(error)
            return nil
        }
    }
}

