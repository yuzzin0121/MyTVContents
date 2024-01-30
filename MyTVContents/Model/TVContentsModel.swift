//
//  TopRatedModel.swift
//  MyTVContents
//
//  Created by 조유진 on 1/31/24.
//

import Foundation

struct TVContentsModel: Decodable {
    let results: [TV]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TV: Decodable {
    let id: Int
    let name: String
    let originalName: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case posterPath = "poster_path"
    }
}
