//
//  HomePage.swift
//  AlzaCaseStudy
//
//  Created by Petr Podzimek DJ on 07.01.2021.
//

import Foundation


struct HomePageSection: Codable {

    let sectionUrl: String

    enum CodingKeys: String, CodingKey {
        case sectionUrl = "href"
    }

}

struct HomePageSelf: Codable {

    let homePageSelf: HomePageSection

    enum CodingKeys: String, CodingKey {
        case homePageSelf = "self"
    }

}

struct HomePage: Codable {
    
    let name: String
    let section: HomePageSelf
    
}

extension HomePage {
    
    init?(data: Data) {
        do {
            let result = try JSONDecoder().decode(HomePage.self, from: data)
            self = result
        }
        catch {
            print(error)
            return nil
        }
    }
}
