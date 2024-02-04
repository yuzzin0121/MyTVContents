//
//  DramaSearchModel.swift
//  MyTVContents
//
//  Created by 조유진 on 2/5/24.
//

import Foundation

struct DramaSearchModel: Decodable {
    let page: Int
    let results: [SearchedDrama]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct SearchedDrama: Decodable {
    let backdropPath: String
    let name: String
    let overview: String
    let firstAirDate: String
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case name
        case overview
        case firstAirDate = "first_air_date"
    }
}
