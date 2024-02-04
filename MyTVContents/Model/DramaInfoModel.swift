//
//  DramaInfoModel.swift
//  MyTVContents
//
//  Created by 조유진 on 1/31/24.
//

import Foundation

struct DramaInfoModel: Decodable {
    let backdropPath: String?
    let createdBy: [Creater]
    let id: Int
    let name: String
    let overview: String
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case id
        case name
        case overview
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
    }
}

struct Creater: Decodable {
    let name: String
}
