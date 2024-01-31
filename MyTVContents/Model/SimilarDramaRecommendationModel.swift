//
//  SimilarDramaRecommendationModel.swift
//  MyTVContents
//
//  Created by 조유진 on 1/31/24.
//

import Foundation

struct SimilarDramaRecommendationModel: Decodable {
    let page: Int
    let results: [SimilarDrama]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
   
}
struct SimilarDrama: Decodable {
    let id: Int
    let name: String
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backdropPath = "backdrop_path"
    }
   
}
