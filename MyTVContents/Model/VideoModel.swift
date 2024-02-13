//
//  VideoModel.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import Foundation

struct VideoModel: Decodable {
    let id: Int
    let results: [Video]
}

struct Video: Decodable {
    let key: String
}
