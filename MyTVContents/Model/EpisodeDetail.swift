//
//  EpisodeDetail.swift
//  MyTVContents
//
//  Created by 조유진 on 2/9/24.
//

import Foundation

struct EpisodeDetail: Decodable {
    let episodes: [Episode]
}

struct Episode: Decodable {
    let episodeNumber: Int
    let id: Int
    let name: String
    let overview: String
    let runtime: Int
    let stillPath: String?
    
    enum CodingKeys: String, CodingKey {
        case episodeNumber = "episode_number"
        case id
        case name
        case overview
        case runtime
        case stillPath = "still_path"
    }
}
